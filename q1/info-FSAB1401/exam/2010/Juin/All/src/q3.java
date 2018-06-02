public double moyenneTemperature() {
    double somme = 0.0;
    int nbValid = 0;

    for(int i = 0; i < mesures.length; i++)
        if(mesures[i].isValid()) {
            nbValid++;
            somme += mesures[i].getTemperature();
        }

    return somme / nbValid;
}

