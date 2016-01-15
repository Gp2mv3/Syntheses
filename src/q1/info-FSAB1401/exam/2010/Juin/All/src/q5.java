public void addMesure(MesureEtendue m) {
    super.addMesure(m);
    if(m.isValid()) maxPression = Math.max(maxPression, m.getPression());
}

