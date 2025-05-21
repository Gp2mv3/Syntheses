#!/usr/bin/env python3
import argparse
import os
import pathlib
import re
import shutil
import sys
import yaml

QUADRI_ID_REGEX = r"^[qQ]?[0-9]$"
OPTION_CODE_REGEX = r"^[A-Z]{3,4}$" # If you ever need to have an option code with less than 3 characters, or with more than 4 characters, here is where you have to update it
NUMERIC_CODE_REGEX = r"^[0-9]{4}$"
COURSE_NAME_REGEX = r"^\w+$"
COURSE_CODE_REGEX = r"^(?P<option_code>[A-Z]+)(?P<numeric_code>[0-9]{4})$"
COURSE_FOLDER_NAME_REGEX = r"^(?P<course_name>\w+)-(?P<option_code>[A-Z]+)(?P<numeric_code>[0-9]{4})$"

p_QUADRI_ID = re.compile(QUADRI_ID_REGEX)
p_OPTION_CODE = re.compile(OPTION_CODE_REGEX)
p_NUMERIC_CODE = re.compile(NUMERIC_CODE_REGEX)
p_COURSE_NAME = re.compile(COURSE_NAME_REGEX)
p_COURSE_CODE = re.compile(COURSE_CODE_REGEX)
p_COURSE_FOLDER_NAME = re.compile(COURSE_FOLDER_NAME_REGEX)


def get_quadri(quadri_str):
    if re.match(QUADRI_ID_REGEX, quadri_str):
        return quadri_str[-1:]


def get_course_code(course_code_str):
    m = re.match(COURSE_CODE_REGEX, course_code_str)
    if m:
        return (m.group('option_code'), m.group('numeric_code'))


def get_course_code_from_arglist(course_code_list):
    if len(course_code_list) == 1:
        course_code = course_code_list[0].upper()
        ret = get_course_code(course_code)
        if ret:
            return ret
        if re.match(OPTION_CODE_REGEX, course_code):
            return (course_code, None)
        if re.match(NUMERIC_CODE_REGEX, course_code):
            return (None, course_code)
    if len(course_code_list) == 2:
        # Assume that the first one is the option code and the second one is the numeric code
        if re.match(OPTION_CODE_REGEX, course_code_list[0].upper()) and re.match(NUMERIC_CODE_REGEX, course_code_list[1]):
            return (course_code_list[0], course_code_list[1])


def get_quadri_from_cwd():
    """Returns the quadri identifier based on the current directory. Returns it as a string."""
    real_path = os.path.realpath(os.getcwd())
    (head, tail) = os.path.split(real_path)
    while tail:
        q = get_quadri(tail)
        if q:
            return q
        (head, tail) = os.path.split(head)


def get_course_name_from_cwd():
    """Returns the course name, option code and numerical code based on the current directory, as a tuple of 3 strings."""
    real_path = os.path.basename(os.getcwd())
    (head, tail) = os.path.split(real_path)
    while tail:
        m = p_COURSE_FOLDER_NAME.match(tail)
        if m:
            return (m.group('course_name'), m.group('option_code'), m.group('numeric_code'))
        (head, tail) = os.path.split(head)


def navigate_to_src_root(chdir=True):
    cwd = os.path.realpath(os.getcwd())
    # Check that we are not in the repo root
    if os.path.exists(os.path.join(cwd, "src")):
        cwd = os.path.join(cwd, "src")
        if chdir:
            os.chdir(cwd)
        return cwd
    # Otherwise, recurse up until being in the "src/" dir
    while True:
        (head, tail) = os.path.split(cwd)
        if tail == 'src':
            break
        if not tail: # We are at the root of the file system
            return None
        cwd = head
    if chdir:
        os.chdir(cwd)
    return cwd


def navigate_to_quadri(quadri, chdir=True):
    # Navigate until being in the "src/" dir
    cwd = navigate_to_src_root(chdir)
    if not cwd:
        return None
    # Then, go into quadri dir
    cwd = os.path.join(cwd, "q{}".format(quadri))
    if not os.path.exists(cwd):
        return None
    if chdir:
        os.chdir(cwd)
    return cwd


def get_course_name_from_course_code(option_code, numeric_code, quadri):
    """
    Returns the course name based on the provided course code and quadri, by navigating the file hierarchy.
    Returns None if no such course code exists in the specified quadri.
    """
    # Navigate until being in the "src/" dir, then go into quadri dir
    cwd = navigate_to_quadri(quadri, chdir=False)
    if not cwd:
        return None
    # Then, scan dirs to find an appropriate course
    ret = None
    with os.scandir(cwd) as course_dirs:
        for course_dir in course_dirs:
            if not course_dir.is_dir():
                continue
            m = p_COURSE_FOLDER_NAME.match(course_dir.name)
            if not m:
                continue # Probably a non-related folder
            if m.group('option_code') == option_code and m.group('numeric_code') == numeric_code:
                if ret:
                    print("Error: multiple course names for the given course code; this should be fixed", file=sys.stderr)
                ret = m.group('course_name')
    return ret


def get_course_code_from_course_name(course_name, quadri):
    """
    Returns the course code (tuple of 2 strings: option code and numerical code) based on the provided course name and quadri, by navigating the file hierarchy.
    Returns None if no such course name exists in the specified quadri.
    """
    # Navigate until being in the "src/" dir, then go into quadri dir
    cwd = navigate_to_quadri(quadri, chdir=False)
    if not cwd:
        return None
    # Then, scan dirs to find an appropriate course
    ret = None
    with os.scandir(cwd) as course_dirs:
        for course_dir in course_dirs:
            if not course_dir.is_dir():
                continue
            m = p_COURSE_FOLDER_NAME.match(course_dir.name)
            if not m:
                continue # Probably a non-related folder
            if m.group('course_name') == course_name:
                if ret:
                    print("Error: multiple course codes for the given course name; this should be fixed", file=sys.stderr)
                ret = (m.group('option_code'), m.group('numeric_code'))
    return ret


def parse_old_course_params(args):
    old_quadri = None
    old_course_name = None
    old_option_code = None
    old_numeric_code = None
    if args.current_course == ['.']:
        # Retrieve the current course by using the current path name
        cur_quadri = get_quadri_from_cwd()
        cur_course_name = get_course_name_from_cwd()
        if not cur_quadri or not cur_course_name:
            print("Error: current working dir doesn't match the format of a course directory; provide a correct course name/course code or change dir", file=sys.stderr)
            sys.exit(-1)
        old_quadri = cur_quadri
        old_course_name = cur_course_name[0]
        old_option_code = cur_course_name[1]
        old_numeric_code = cur_course_name[2]
    else:
        # In theory, we have both a quadri and a course name, or a quadri and a course code
        for i in range(len(args.current_course)):
            s = args.current_course[i]

            if re.match(QUADRI_ID_REGEX, s):
                t_oq = s[-1:]
                if old_quadri and old_quadri != t_oq:
                    print("Error: two different quadris specified: {} and {}".format(old_quadri, t_oq), file=sys.stderr)
                    sys.exit(-1)
                old_quadri = t_oq
                continue # If it matched a quadri, it is not a course name nor course code so we can skip it

            m_course_code = re.match(COURSE_CODE_REGEX, str(s).upper())
            if m_course_code:
                t_oc = m_course_code.group('option_code')
                t_nc = m_course_code.group('numeric_code')
                if (old_option_code and old_option_code != t_oc) or (old_numeric_code and old_numeric_code != t_nc):
                    print("Error: two different course codes specified: {}{} and {}{}".format(old_option_code, old_numeric_code, t_oc, t_nc), file=sys.stderr)
                    sys.exit(-1)
                old_option_code = t_oc
                old_numeric_code = t_nc
                continue # If it matched a course code, it is not a course name so we can skip the last step

            if re.match(NUMERIC_CODE_REGEX, s):
                t_nc = s
                if old_numeric_code and old_numeric_code != t_nc:
                    print("Error: two different numerical codes specified: {} and {}".format(old_numeric_code, t_nc), file=sys.stderr)
                    sys.exit(-1)
                old_numeric_code = t_nc
                continue

            if re.match(OPTION_CODE_REGEX, str(s).upper()):
                if i+1 < len(args.current_course) and re.match(NUMERIC_CODE_REGEX, args.current_course[i+1]):
                    old_option_code = str(s).upper()
                    # old_numeric_code will be done at next iter

            if re.match(COURSE_NAME_REGEX, s):
                if i+1 < len(args.current_course) and re.match(NUMERIC_CODE_REGEX, args.current_course[i+1]):
                    continue # Skip this iter
                t_cn = s
                if old_course_name and old_course_name != t_cn:
                    print("Error: two different course names specified: {} and {}".format(old_course_name, t_cn), file=sys.stderr)
                    sys.exit(-1)
                old_course_name = t_cn

        if old_option_code and not old_numeric_code:
            old_option_code = None # We've mistaken the course name for the option code

        if not old_quadri:
            # Look the old quadri in the current folder and up
            cur_quadri = get_quadri_from_cwd()
            if cur_quadri:
                old_quadri = cur_quadri
            else:
                print("Error: no quadri specified nor inferable: either specify one, or move in the correct quadri folder, or a subfolder of it", file=sys.stderr)
                sys.exit(-1)

        if not old_course_name and not old_numeric_code:
            # Look the current course in the current folder and up
            cur_course_name = get_course_name_from_cwd()
            if not cur_course_name:
                print("Error: no course name/code specified nor inferable: either specify one, or move in the correct course folder, or a subfolder of it", file=sys.stderr)
                sys.exit(-1)
            old_course_name = cur_course_name[0]
            old_option_code = cur_course_name[1]
            old_numeric_code = cur_course_name[2]

        # If only one of the two was specified, find the other by navigating the folder hierarchy
        if not old_course_name:
            old_course_name = get_course_name_from_course_code(old_option_code, old_numeric_code, old_quadri)
            if not old_course_name:
                print("Error: couldn't find the specified course in quadri {} with code {}{}".format(old_quadri, old_option_code, old_numeric_code))
                sys.exit(-1)
        if not old_option_code:
            ret = get_course_code_from_course_name(old_course_name, old_quadri)
            if not ret:
                print("Error: couldn't find the specified course in quadri {} with course name {}".format(old_quadri, old_course_name))
                sys.exit(-1)
            (old_option_code, old_numeric_code) = ret

        # Check that the course name and course code are coherent
        correct_course_name = get_course_name_from_course_code(old_option_code, old_numeric_code, old_quadri)
        if correct_course_name != old_course_name:
            print("Error: course name doesn't match course code and quadri: specified course name {} and code {}{} but correct name is {}".format(old_course_name, old_option_code, old_numeric_code, correct_course_name), file=sys.stderr)
            sys.exit(-1)
    return {'quadri': old_quadri, 'course_name': old_course_name, 'option_code': old_option_code, 'numeric_code': old_numeric_code}


def get_course_title(course_name):
    with open("config.yml", 'r', encoding='utf-8') as f:
        try:
            document = yaml.safe_load(f)
            type(document['title'][course_name])
            print(document['title'][course_name])
            return document['title'][course_name]
        except yaml.YAMLError as e:
            print("Error: got exception {} while getting course title, aborting".format(str(e)), file=sys.stderr)
            sys.exit(-1)


def update_course_title(old_course_name, new_course_name, new_course_title):
    """Should be called from src/ root"""
    # TODO: set default_flow_style=False in dump
    with open("config.yml", 'r+', encoding='utf-8') as f:
        try:
            document = yaml.safe_load(f)
            f.seek(0)
            if old_course_name not in document['title']:
                print("Error: course name was not found in config.yml", file=sys.stderr)
                sys.exit(-2)
            del document['title'][old_course_name]
            document['title'][new_course_name] = new_course_title
            yaml.dump(document, f, allow_unicode=True, default_flow_style=False, indent=4, encoding='utf-8')
        except yaml.YAMLError as e:
            print("Error: got exception {} while updating course title, aborting".format(str(e)), file=sys.stderr)
            sys.exit(-2)


def ensure_option_code_in_yaml(new_option_code, silent=False):
    """Should be called from src/ root"""
    with open("config.yml", 'r+', encoding='utf-8') as f:
        try:
            document = yaml.safe_load(f)
            f.seek(0)
            if new_option_code not in document['option']:
                print("WARNING: Option code {} was not found in config.yml; you need to manually add it".format(new_option_code))
                if not silent:
                    rep = input("Would you like me to update it? [Y/N]\n")
                    if rep in ['Y', 'y']:
                        new_target = input("Please enter the target directory for this option."
                                "This should match a directory in the EPL Drive."
                                "Leave this empty if you want to add the line to config.yml without a target name (you need to update it later).\n")
                        document['option'][new_option_code] = new_target
                        yaml.dump(document, f, allow_unicode=True, default_flow_style=False, indent=4, encoding='utf-8')
        except yaml.YAMLError as e:
            print("Error: got exception {} while updating course title, aborting".format(str(e)), file=sys.stderr)
            sys.exit(-2)


def update_course_mk(new_course_name, new_option_code, new_numeric_code, new_quadri):
    """Should be called from course folder"""
    with open("{}-{}{}.mk".format(new_course_name, new_option_code, new_numeric_code), 'w') as f:
        f.writelines([
            "NAME={}\n".format(new_course_name),
            "OPTION={}\n".format(new_option_code),
            "CODE={}\n".format(new_numeric_code),
            "include $(BASE_DIR)../../q{}.mk\n".format(new_quadri)
        ])


def update_mk_file(filename, old_course_folder_name, new_course_folder_name):
    """Aux function for the two next functions; updates the content of a exam.mk, test.mk, or Makefile to replace the old course name by the new one, at the line with "include", without changing anything else"""
    with open(filename, 'r+', newline='') as f:
        txt = f.read()
        s_idx = txt.find(old_course_folder_name)
        e_idx = txt.find(".mk")
        ending = txt[e_idx:] # Yep, this is disgusting; this is to recover the correct line ending on all platforms
        f.seek(s_idx)
        f.truncate()
        f.write(new_course_folder_name + ending)


def update_exam_mk(path, old_course_folder_name, new_course_folder_name):
    """Updates the content of an exam.mk or test.mk file to refer to the new course name; specifically, changes the line with the include"""
    basename = os.path.basename(path)
    mk_file_name = os.path.join(path, basename + ".mk")
    print("Changing {}".format(mk_file_name))
    update_mk_file(mk_file_name, old_course_folder_name, new_course_folder_name)


def update_summary_Makefile(path, old_course_folder_name, new_course_folder_name):
    """Updates the content of a Makefile (in direct children of course folder); specifically, changes the line with the include"""
    Makefile_file_name = os.path.join(path, "Makefile")
    print("Changing {}".format(Makefile_file_name))
    update_mk_file(Makefile_file_name, old_course_folder_name, new_course_folder_name)


def update_tex_file(path, files, old_course_name, old_option_code, old_numeric_code, new_quadri, new_course_name, new_option_code, new_numeric_code, new_course_title):
    """Updates the \hypertitle of the .tex file"""
    for file in files:
        # TODO: maybe, we can match only a filename without enforcing the course params, but anyway
        m = re.match("^{}-{}{}(?P<rest_name>-(?P<doctype>[\w-]+).tex)$".format(old_course_name, old_option_code, old_numeric_code), file)
        if m:
            # Rename file
            print("Renaming .tex file {}".format(os.path.join(path, file)))
            new_file_name = "{}-{}{}{}".format(new_course_name, new_option_code, new_numeric_code, m.group('rest_name'))
            os.rename(os.path.join(path, file), os.path.join(path, new_file_name))
            # Change hypertitle
            print("Changing its \\hypertitle")
            lines = []
            with open(os.path.join(path, new_file_name), 'r', encoding='utf-8') as f:
                lines = f.readlines()
            for i in range(len(lines)):
                line = lines[i]
                m2 = re.match(r"^\\hypertitle(?P<prefix>\[.*\])?{[^}]+}{\d}{[A-Z]{3,4}}{\d{4}}(?P<rest_title>.*)", line, flags=re.S)
                if m2:
                    lines[i] = "\hypertitle{5}{{{0}}}{{{1}}}{{{2}}}{{{3}}}{4}".format(
                            new_course_title, new_quadri, new_option_code, new_numeric_code, m2.group('rest_title'), m2.group('prefix') or "")
                    break
            with open(os.path.join(path, new_file_name), 'w', encoding='utf-8') as f:
                f.writelines(lines)
            break # Only one such file should be present anyway



if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Rename and move courses, and update related files accordingly",
            epilog=("Here, course name is like \"meca\", \"crypto\", \"digital\". Case-sensitive!"
                    "Should only contain lowercase ASCII letters, but digits and uppercase ASCII letters are acceptable if needed; concatenate multi-word course namesi.\n\n"
                    "Course title is like \"Mécanique\", \"Cryptography\", \"Eléments finis\"."
                    "Should be the official course name as given on the EPL Drive and on the official course page."
                    "Report any inconsistency between the two to EPL Drive and GitHub admins.\n\n"
                    "Quadri identifier is either a digit or a digit prefixed with a 'q' or 'Q', ex: Q1, q2, 3.\n\n"
                    "(Course) code is \"MECA1120\" or \"EPL1101\", and is composed of an option (in uppercase letters, but the program is case-insensitive for this) and a numerical code (in digits)."
                    "The option doesn't have the usually leading 'L'.\n"
                    "When used in renaming, one of the option code or numerical code can be omitted; the omitted part will reuse the old corresponding value.\n")
            )
    parser.add_argument('current_course', nargs='+',
            help="Current course name. Must contain a course name or course code, an optional quadri identifier (default is taken from current dir, else it fails), or '.', in which case the current folder is used (must be a course folder)")
    parser.add_argument('--code', nargs='+', help="New course code. Composed of two parts, an option code in letters and a numerical code in digits (the parts can be split or concatenated). See below for more info.")
    parser.add_argument('--quadri', help="New course quadri identifier; see below.")
    parser.add_argument('--course_name', help="New course name; see below.")
    parser.add_argument('--course_title', help="New course title; see below for details.")
    parser.add_argument('--git', action='store_true', default=False, help="Update the changes to Git (via git add); not recommanded if you have made other changes to the files. Currently unavailable anyway.")
    parser.add_argument('--force', '-f', action='store_true', default=False, help="Force the changes to be made, regardless of potential issues")
    parser.add_argument('--silent', '-s', action='store_true', default=False, help="Disables the program from prompting additional informations/decisions.")
    args = parser.parse_args()
    # config.yml: only needs to be updated if we change the course name or the course title
    # <course_name>-<option_code><numeric_code> folder: rename if course name/option code/numerical code
    # <course_name>-<option_code><numeric_code>.mk:
    #   - change "NAME" and <course_name> if course_name
    #   - change "OPTION" and <option_code> if option code
    #   - change "CODE" and <numeric_code> if numerical code
    #   - change the quadri .mk pointer if quadri
    # Makefile for summaries, notes, exercises, formulaires, erratas, mcqs: change the .mk pointer
    # .tex for summaries, notes, exercises, formularies:
    #   - change the filename if course name/option code/numerical code;
    #   - change the course title, quadri, option code, numerical code, if needed (surprisingly, not the course name)
    # exam.mk, test.mk: change its .mk pointer with course name/option code/numerical code
    # .tex for exams, tests:
    #   - change filename for course name/option code/numerical code
    #   - change course title, quadri, course name, option code, numerical code if needed

    # Get the old names
    old_course_params = parse_old_course_params(args)
    old_quadri = old_course_params['quadri']
    old_course_name = old_course_params['course_name']
    old_option_code = old_course_params['option_code']
    old_numeric_code = old_course_params['numeric_code']

    # Get the new names
    new_quadri = old_quadri
    new_course_name = old_course_name
    new_option_code = old_option_code
    new_numeric_code = old_numeric_code
    change_course_title = False
    new_course_title = None
    if args.quadri:
        new_quadri = get_quadri(args.quadri)
        if not new_quadri:
            print("Error: new quadri invalid, aborting", file=sys.stderr)
            sys.exit(-1)
    if args.course_name:
        if re.match(COURSE_NAME_REGEX, args.course_name):
            new_course_name = args.course_name
    if args.code:
        r = get_course_code_from_arglist(args.code)
        if not r or r == (None, None):
            print("Error: bad specs for new course code", file=sys.stderr)
            sys.exit(-1)
        if r[0]:
            new_option_code = r[0]
        if r[1]:
            new_numeric_code = r[1]
    if args.course_title:
        new_course_title = args.course_title
        change_course_title = True

    navigate_to_src_root()

    old_course_title = get_course_title(old_course_name)
    if not change_course_title:
        new_course_title = old_course_title

    print("Course to be modified:\n"
          "\tQuadri {}\n"
          "\tCourse name {}\n"
          "\tCourse code {}{}\n".format(old_quadri, old_course_name, old_option_code, old_numeric_code))
    if change_course_title:
        print("\tCourse title \"{}\"".format(old_course_title))
    print("New course parameters after modifications:\n"
        + "\tQuadri {}{}\n".format(new_quadri, " (changed from {})".format(old_quadri) if old_quadri != new_quadri else "")
        + "\tCourse name {}{}\n".format(new_course_name, " (changed from {})".format(old_course_name) if old_course_name != new_course_name else "")
        + "\tCourse code {}{}{}\n".format(new_option_code, new_numeric_code, " (changed from {}{})".format(old_option_code, old_numeric_code) if old_option_code != new_option_code or old_numeric_code != new_numeric_code else ""))
    if change_course_title:
        print("\tCourse title \"{}\"".format(new_course_title))

    old_course_folder_name = "{}-{}{}".format(old_course_name, old_option_code, old_numeric_code)
    new_course_folder_name = "{}-{}{}".format(new_course_name, new_option_code, new_numeric_code)

    print("Ensuring the new code is present in config.yml")
    ensure_option_code_in_yaml(new_option_code)

    if change_course_title:
        print("Changing course title in config.yml")
        update_course_title(old_course_name, new_course_name, new_course_title)
    if old_course_name != new_course_name:
        print("Changing course name in config.yml")
        update_course_title(old_course_name, new_course_name, new_course_title)

    # Perform the renaming/moving
    src_root = os.getcwd()

    # Move quadri, if needed
    if old_quadri != new_quadri:
        print("Changing quadri")
        shutil.move(
            os.path.join(src_root, 'q{}'.format(old_quadri), old_course_folder_name),
            os.path.join(src_root, 'q{}'.format(new_quadri)))

    # Move to quadri folder, to have shorter paths
    os.chdir('q{}'.format(new_quadri))

    # Rename course folder if needed
    change_course_folder_name = (old_course_folder_name != new_course_folder_name)
    if change_course_folder_name:
        print("Changing course folder name")
        os.rename(old_course_folder_name, new_course_folder_name)

    # Move to course folder, to have shorter paths
    os.chdir(new_course_folder_name)

    # Renaming of course folder, second step
    if change_course_folder_name:
        os.rename(old_course_folder_name + ".mk", new_course_folder_name + ".mk")

    print("Changing course .mk")
    update_course_mk(new_course_name, new_option_code, new_numeric_code, new_quadri)

    # Walk all files to make the necessary edits
    for path, dirs, files in os.walk('.'):
        basename = os.path.basename(path)
        if basename == "exam" or basename == "test":
            # Need to update the exam.mk file to replace the course_folder_name in include
            update_exam_mk(path, old_course_folder_name, new_course_folder_name)
        if basename in ["All", "Maj", "Majeure", "Min", "Mineure"]:
            # Need to update the .tex; the Makefile doesn't need any change per se
            update_tex_file(path, files, old_course_name, old_option_code, old_numeric_code, new_quadri, new_course_name, new_option_code, new_numeric_code, new_course_title)
        if basename.startswith("summary") or basename.startswith("notes") or basename.startswith("exercises") or basename.startswith("mcq") or basename.startswith("errata"):
            # Need to update the .tex and the Makefile (include ../course_folder_name.mk
            update_summary_Makefile(path, old_course_folder_name, new_course_folder_name)
            update_tex_file(path, files, old_course_name, old_option_code, old_numeric_code, new_quadri, new_course_name, new_option_code, new_numeric_code, new_course_title)

    print("Done.")

