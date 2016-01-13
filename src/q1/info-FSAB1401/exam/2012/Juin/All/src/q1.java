/**
 * @pre  title != null, author != null, duration > 0
 * @post construit un objet Song
 */
public Song(String title, String author, int duration) {
    assert title  != null : "Titre non defini";
    assert author != null : "Auteur non defini";
    assert duration > 0   : "Duree non positive";
    
    this.title    = title;
    this.author   = author;
    this.duration = duration;
}
