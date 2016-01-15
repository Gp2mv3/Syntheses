public void addMesure(MesureEtendue m) {
    for(int i = mesures.length-1; i > 0; i--)
        mesures[i] = mesures[i-1];
    mesures[0] = m;
}

