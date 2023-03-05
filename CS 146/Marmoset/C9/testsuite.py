from random import *

racket = []
c = []

for i in range(30):
    l1 = randint(1,10)
    l2 = randint(1,10)
    
    n1 = [str(randint(0,10000)) for j in range(l1)]
    n2 = [str(randint(0,10000)) for j in range(l2)]
    
    racket.append("(blist-to-nat (mult (list n1) (list n2)))".replace("n1", " ".join(n1)).replace("n2", " ".join(n2)))
    
    temp1 = "cons_bigit(" + ", cons_bigit(".join(n1) + ", NULL" + ")"*len(n1)
    temp2 = "cons_bigit(" + ", cons_bigit(".join(n2) + ", NULL" + ")"*len(n2)
    
    c.append("print_num(mult(n1, n2));printf('\n');".replace("n1", temp1).replace("n2", temp2))
    
print("\n".join(racket))
print("\n".join(c))