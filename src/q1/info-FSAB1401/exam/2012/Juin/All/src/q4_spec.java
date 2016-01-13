/**
 * @pre songin != null, songnew != null, songin est present une fois dans la liste.
 * @post Insere songnew dans la liste "juste avant" songin. Si les
 chansons sont retirees de la liste en utilisant la methode dequeue
 apres cette insertion, alors lorsque dequeue retirera songnew, la chanson suivante a retirer sera songin.
*/
public void addBefore(Song songin, Song songnew) {

