/**
 * @pre  title != null, author != null, duration > 0
 * @post Crée une chanson de titre {title}, par {author} et durant {duration} secondes.
 */
public Song(String title, String author, int duration) {
    this.title    = title;
    this.author   = author;
    this.duration = duration;
}
