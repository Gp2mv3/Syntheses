public MesureEtendue(int pression, double temperature) {
    super(pression, temperature);
    validite = (pression > 0 && temperature > TEMPERATURE_0K);
}

