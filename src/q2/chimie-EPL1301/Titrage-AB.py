
# Chimie - Titrage acide base 
from math import *
 
def titrage_HAf (C_Ha , V_Ha, pka, C_B, vol_add_b = None, vol_add_af = None):
    """
    Titrage d'un acide faible avec une base forte \n
    C_B = concentration base forte \n
    V_Ha = volume acide à titrer \n
    C_Ha = concentration de l'acide faible \n
    vol_add_b = ajout de titrant avant équivalence \n
    vol_add_af = ajout de titrant après équivalence
    """
        
    pkb = 14-pka
    n_Ha = C_Ha * V_Ha
    x = sqrt(C_Ha * 10**(-pka))                 # /!\ vérifier pourcentage de déprotonation
    ph_init = -log10(x)
    print("pH initial = {:.3f}".format(ph_init))
    print("pH demi = pka = ", pka)
    vol_ajout = n_Ha/C_B
    if vol_add_b != None:
        if vol_add_b < vol_ajout:
            n_b = vol_add_b * C_B
            new_n_HA = n_Ha - n_b
            pH = pka + log10(n_b/new_n_HA)
            print("pH après ajout de titrant avant équivalence = ", pH)
        if vol_add_b > vol_ajout:
            V_new_Ha = vol_add_b - vol_ajout
            pH = - log10((10**(-14))/((V_new_Ha * C_B)/((V_Ha + vol_ajout) + V_new_Ha)))
            print("pH après ajout de titrant avant équivalence = ", pH)
        if vol_add_b == vol_ajout:
            print("pH après ajout de titrant avant équivalence = ", pka)
    print("nombre de mol à équivalence = ", n_Ha )
    print("volume ajouté = ", vol_ajout )
    vol_tot = V_Ha + vol_ajout
    CH30 = (10**(-14))/((10**(-pkb) - sqrt((10**(-pkb))**2 - (-4 * 10**(-pkb) * (n_Ha/vol_tot))))/-2)
    ph_equ = -log10(CH30)
    print("pH à l'équivalence = {:.3f}".format(ph_equ))
    if vol_add_af != None:
        ph_fin = - log10((10**(-14))/((vol_add_af * C_B)/(vol_tot + vol_add_af)))
        print("ph après équ + titrant = ", ph_fin)


def titrage_Bf (C_B , V_B, pka, C_HA, vol_add_b = None, vol_add_af = None):       
    """
    Titrage d'une base faible avec un acide fort \n
    C_B = concentration base faible \n
    V_B = volume base à titrer \n
    C_HA = concentration de l'acide fort \n
    vol_add_b = ajout de titrant avant équivalence \n
    vol_add_af = ajout de titrant après équivalence
    """
    
    pkb = 14-pka
    n_B = C_B*V_B
    OH = sqrt(C_B*10**(-pkb))
    ph_init = -log10((10**-14)/OH)
    print("pH initial = {:.3f}".format(ph_init))
    print("pH demi = pka = " , pka)
    vol_ajout = n_B /C_HA
    if vol_add_b != None:
        if vol_add_b < vol_ajout:
            pH = pka + log10((n_B - (vol_add_b * C_HA))/(vol_add_b * C_HA))
            print("pH après ajout de titrant avant équivalence = ", pH)
        if vol_add_b > vol_ajout:
            pH = - log10((vol_add_af * C_HA)/(vol_tot + vol_add_af))
            print("pH après ajout de titrant avant équivalence = ", pH)
        if vol_add_b == vol_ajout:
            print("pH après ajout de titrant avant équivalence = ", pka)
    print("volume ajouté de l'acide à l'équivalence = ", vol_ajout)
    vol_tot = V_B + vol_ajout
    H3O = (10**(-pka) - sqrt((10**(-pka))**2 - (-4 * 10**(-pka) * (n_B/vol_tot))))/-2
    if pka < 15.74 :
        ph_equ = -log10(H3O)
        print("pH à l'équivalence = {:.3f}".format(ph_equ))
    else :
        print("pH à l'équivalence = 7 car titrage d'une BF par un AF")
    if vol_add_af != None:
        ph_fin = - log10((vol_add_af * C_HA)/(vol_tot + vol_add_af))
        print("pH après équivalence + titrant = ", ph_fin)
    
    
titrage_HAf(.25, .025 , 4.76, .5)
print("\n")
#titrage_Bf(.2, .02 , 10.61, .1)