#!/usr/bin/python

import sys
import time as t
import math

def binomial(k,n):
    result = 1
    for i in range(1, k + 1):
        result = result * (n - i + 1) / i
    return result

def graph_binomial(k, time):
    p = time / 28800
    q = 1 - p
    n = 3500
    res = binomial(k, n) * p ** k * q ** (n - k)
    return res

def aff_graph(n):
    
    return

def aff_lois(nb_sec):
    univers = 1.0
    i = 0
    start = t.time()
    while (i <= 25):
        univers = univers - graph_binomial(i, nb_sec)
        i = i + 1
    end = t.time()
    ms = (end - start)
    print "loi binomiale :\n\t\tTemps de calcul:\t\t%d ms" % ms
    return univers 

def main():
    pourcentage = '%'
    if len(sys.argv) == 2:
        if float(sys.argv[1]) < 0:
            print "Erreur: Le nombre de secondes moyen par appel ne peux etre negatif"
            return
        print "\t\tProbabilite d'encombrement:\t %.1f %s " % (aff_lois(float(sys.argv[1])) * 100, pourcentage)
        aff_graph(float(sys.argv[1]))
        return
    elif len(sys.argv) == 3:
        if float(sys.argv[1]) > float(sys.argv[2]):
            print "Erreur: k ne peux etre plus grand que n"
            return
        elif float(sys.argv[1]) < 0:
            print "Erreur: k ne peux etre negatif"
            return
        res = binomial(float(sys.argv[1]), float(sys.argv[2]))
        print 'Combinaison de %s parmi %s : %d' % (sys.argv[1], sys.argv[2], res)
        return
    else:
        print "Usage: python 203hotline <k> <n>"
        print "Usage: python 203hotline <n>"
        return

main()
