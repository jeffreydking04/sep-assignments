class ActorNode
  attr_accessor :name
  attr_accessor :film_actor_hash

  def initialize(name)
    @name = name
    @film_actor_hash = {}
  end
end

def find_kevin_bacon(actor)
  answer = fkb(actor)
  if !answer
    puts "There is no connection between #{actor.name} and Kevin Bacon."
    return
  end
  degrees_of_separation = (answer.size - 1) / 2
  puts "#{actor.name} is separated from Kevin Bacon by #{degrees_of_separation} degrees."
  puts "#{actor.name} was in:"
  (1...answer.size - 2).step(2).each do |x|
    puts "#{answer[x]} with #{answer[x + 1]} who was in:"
  end
  puts "#{answer[-2]} with Kevin Bacon."
end

def fkb(actor)
  actors_hash = {}
  actors_hash[actor.name] = [actor.name]
  actors_array = [actor]
  while(actors_array[0])
    actors_array[0].film_actor_hash.each do |film, actors|
      actors.each do |person|
        if !actors_hash.keys.include?(person.name)
          path = []
          actors_hash[actors_array[0].name].each do |x|
            path << x
          end
          path << film
          path << person.name
          actors_hash[person.name] = path
          actors_array << person
        end
        return path if person.name == "Kevin_Bacon"
      end
    end
    actors_array.delete_at(0)
  end
end

# This code populates a test environment (I recommend collapsing it.)
Kevin_Bacon = ActorNode.new("Kevin_Bacon")
a  = ActorNode.new ("a")
b  = ActorNode.new("b")
c  = ActorNode.new("c")
d  = ActorNode.new("d")
e  = ActorNode.new("e")
f  = ActorNode.new("f")
g  = ActorNode.new("g")
h  = ActorNode.new("h")
i  = ActorNode.new("i")
j  = ActorNode.new("j")
k  = ActorNode.new("k")
l  = ActorNode.new("l")
m  = ActorNode.new("m")
n  = ActorNode.new("n")
o  = ActorNode.new("o")
p  = ActorNode.new("p")
q  = ActorNode.new("q")
r  = ActorNode.new("r")
s  = ActorNode.new("s")
t  = ActorNode.new("t")
u  = ActorNode.new("u")
v  = ActorNode.new("v")
w  = ActorNode.new("w")
x  = ActorNode.new("x")
y  = ActorNode.new("y")
z  = ActorNode.new("z")
aa = ActorNode.new("aa")
ab = ActorNode.new("ab")
ac = ActorNode.new("ac")
ad = ActorNode.new("ad")
ae = ActorNode.new("ae")
af = ActorNode.new("af")
ag = ActorNode.new("ag")
ah = ActorNode.new("ah")
ai = ActorNode.new("ai")
aj = ActorNode.new("aj")
ak = ActorNode.new("ak")
al = ActorNode.new("al")
am = ActorNode.new("am")
an = ActorNode.new("an")
ao = ActorNode.new("ao")
ap = ActorNode.new("ap")
aq = ActorNode.new("aq")
ar = ActorNode.new("ar")
as = ActorNode.new("as")
at = ActorNode.new("at")
au = ActorNode.new("au")
av = ActorNode.new("av")
aw = ActorNode.new("aw")
ax = ActorNode.new("ax")
ay = ActorNode.new("ay")
az = ActorNode.new("az")



f.film_actor_hash["JB"] = [aj, t, z, q, ay, av, o]
aj.film_actor_hash["JB"] = [f, t, z, q, ay, av, o]
t.film_actor_hash["JB"] = [f, aj, z, q, ay, av, o]
z.film_actor_hash["JB"] = [f, aj, t, q, ay, av, o]
q.film_actor_hash["JB"] = [f, aj, t, z, ay, av, o]
ay.film_actor_hash["JB"] = [f, aj, t, z, q, av, o]
av.film_actor_hash["JB"] = [f, aj, t, z, q, ay, o]
o.film_actor_hash["JB"] = [f, aj, t, z, q, ay, av]
i.film_actor_hash["JC"] = [j, ae, l, aa, ay]
j.film_actor_hash["JC"] = [i, ae, l, aa, ay]
ae.film_actor_hash["JC"] = [i, j, l, aa, ay]
l.film_actor_hash["JC"] = [i, j, ae, aa, ay]
aa.film_actor_hash["JC"] = [i, j, ae, l, ay]
ay.film_actor_hash["JC"] = [i, j, ae, l, aa]
ab.film_actor_hash["JD"] = [ac, c, b, j, az, ak, a]
ac.film_actor_hash["JD"] = [ab, c, b, j, az, ak, a]
c.film_actor_hash["JD"] = [ab, ac, b, j, az, ak, a]
b.film_actor_hash["JD"] = [ab, ac, c, j, az, ak, a]
j.film_actor_hash["JD"] = [ab, ac, c, b, az, ak, a]
az.film_actor_hash["JD"] = [ab, ac, c, b, j, ak, a]
ak.film_actor_hash["JD"] = [ab, ac, c, b, j, az, a]
a.film_actor_hash["JD"] = [ab, ac, c, b, j, az, ak]
ao.film_actor_hash["JF"] = [r, ax, as, e, az, b]
r.film_actor_hash["JF"] = [ao, ax, as, e, az, b]
ax.film_actor_hash["JF"] = [ao, r, as, e, az, b]
as.film_actor_hash["JF"] = [ao, r, ax, e, az, b]
e.film_actor_hash["JF"] = [ao, r, ax, as, az, b]
az.film_actor_hash["JF"] = [ao, r, ax, as, e, b]
b.film_actor_hash["JF"] = [ao, r, ax, as, e, az]
b.film_actor_hash["JG"] = [l, aa, v, az, r]
l.film_actor_hash["JG"] = [b, aa, v, az, r]
aa.film_actor_hash["JG"] = [b, l, v, az, r]
v.film_actor_hash["JG"] = [b, l, aa, az, r]
az.film_actor_hash["JG"] = [b, l, aa, v, r]
r.film_actor_hash["JG"] = [b, l, aa, v, az]
r.film_actor_hash["JH"] = [ax, ad, ar, an, j, aw, l]
ax.film_actor_hash["JH"] = [r, ad, ar, an, j, aw, l]
ad.film_actor_hash["JH"] = [r, ax, ar, an, j, aw, l]
ar.film_actor_hash["JH"] = [r, ax, ad, an, j, aw, l]
an.film_actor_hash["JH"] = [r, ax, ad, ar, j, aw, l]
j.film_actor_hash["JH"] = [r, ax, ad, ar, an, aw, l]
aw.film_actor_hash["JH"] = [r, ax, ad, ar, an, j, l]
l.film_actor_hash["JH"] = [r, ax, ad, ar, an, j, aw]
au.film_actor_hash["JI"] = [c, aw, l, g, af]
c.film_actor_hash["JI"] = [au, aw, l, g, af]
aw.film_actor_hash["JI"] = [au, c, l, g, af]
l.film_actor_hash["JI"] = [au, c, aw, g, af]
g.film_actor_hash["JI"] = [au, c, aw, l, af]
af.film_actor_hash["JI"] = [au, c, aw, l, g]
l.film_actor_hash["JJ"] = [ab, ay, aw, i, ak, u]
ab.film_actor_hash["JJ"] = [l, ay, aw, i, ak, u]
ay.film_actor_hash["JJ"] = [l, ab, aw, i, ak, u]
aw.film_actor_hash["JJ"] = [l, ab, ay, i, ak, u]
i.film_actor_hash["JJ"] = [l, ab, ay, aw, ak, u]
ak.film_actor_hash["JJ"] = [l, ab, ay, aw, i, u]
u.film_actor_hash["JJ"] = [l, ab, ay, aw, i, ak]
ak.film_actor_hash["JK"] = [n, g, d, aw, au]
n.film_actor_hash["JK"] = [ak, g, d, aw, au]
g.film_actor_hash["JK"] = [ak, n, d, aw, au]
d.film_actor_hash["JK"] = [ak, n, g, aw, au]
aw.film_actor_hash["JK"] = [ak, n, g, d, au]
au.film_actor_hash["JK"] = [ak, n, g, d, aw]
ah.film_actor_hash["JL"] = [aq, a, av, ae, aj, an]
aq.film_actor_hash["JL"] = [ah, a, av, ae, aj, an]
a.film_actor_hash["JL"] = [ah, aq, av, ae, aj, an]
av.film_actor_hash["JL"] = [ah, aq, a, ae, aj, an]
ae.film_actor_hash["JL"] = [ah, aq, a, av, aj, an]
aj.film_actor_hash["JL"] = [ah, aq, a, av, ae, an]
an.film_actor_hash["JL"] = [ah, aq, a, av, ae, aj]
ar.film_actor_hash["JM"] = [ac, b, d, as, z, aw, aq]
ac.film_actor_hash["JM"] = [ar, b, d, as, z, aw, aq]
b.film_actor_hash["JM"] = [ar, ac, d, as, z, aw, aq]
d.film_actor_hash["JM"] = [ar, ac, b, as, z, aw, aq]
as.film_actor_hash["JM"] = [ar, ac, b, d, z, aw, aq]
z.film_actor_hash["JM"] = [ar, ac, b, d, as, aw, aq]
aw.film_actor_hash["JM"] = [ar, ac, b, d, as, z, aq]
aq.film_actor_hash["JM"] = [ar, ac, b, d, as, z, aw]
d.film_actor_hash["JN"] = [az, m, n, ah, v]
az.film_actor_hash["JN"] = [d, m, n, ah, v]
m.film_actor_hash["JN"] = [d, az, n, ah, v]
n.film_actor_hash["JN"] = [d, az, m, ah, v]
ah.film_actor_hash["JN"] = [d, az, m, n, v]
v.film_actor_hash["JN"] = [d, az, m, n, ah]
at.film_actor_hash["JO"] = [u, a, aw, v, ab]
u.film_actor_hash["JO"] = [at, a, aw, v, ab]
a.film_actor_hash["JO"] = [at, u, aw, v, ab]
aw.film_actor_hash["JO"] = [at, u, a, v, ab]
v.film_actor_hash["JO"] = [at, u, a, aw, ab]
ab.film_actor_hash["JO"] = [at, u, a, aw, v]
h.film_actor_hash["JP"] = [ah, c, an, o, j, a]
ah.film_actor_hash["JP"] = [h, c, an, o, j, a]
c.film_actor_hash["JP"] = [h, ah, an, o, j, a]
an.film_actor_hash["JP"] = [h, ah, c, o, j, a]
o.film_actor_hash["JP"] = [h, ah, c, an, j, a]
j.film_actor_hash["JP"] = [h, ah, c, an, o, a]
a.film_actor_hash["JP"] = [h, ah, c, an, o, j]
t.film_actor_hash["JQ"] = [ag, au, aj, ai, ar]
ag.film_actor_hash["JQ"] = [t, au, aj, ai, ar]
au.film_actor_hash["JQ"] = [t, ag, aj, ai, ar]
aj.film_actor_hash["JQ"] = [t, ag, au, ai, ar]
ai.film_actor_hash["JQ"] = [t, ag, au, aj, ar]
ar.film_actor_hash["JQ"] = [t, ag, au, aj, ai]
aw.film_actor_hash["JS"] =  [a, v, y, l, ad, am]
a.film_actor_hash["JS"] = [aw, v, y, l, ad, am]
v.film_actor_hash["JS"] = [aw, a, y, l, ad, am]
y.film_actor_hash["JS"] = [aw, a, v, l, ad, am]
l.film_actor_hash["JS"] = [aw, a, v, y, ad, am]
ad.film_actor_hash["JS"] = [aw, a, v, y, l, am]
am.film_actor_hash["JS"] = [aw, a, v, y, l, ad]
af.film_actor_hash["JT"] = [ar, ax, k, ai, aj, at, am]
ar.film_actor_hash["JT"] = [af, ax, k, ai, aj, at, am]
ax.film_actor_hash["JT"] = [af, ar, k, ai, aj, at, am]
k.film_actor_hash["JT"] = [af, ar, ax, ai, aj, at, am]
ai.film_actor_hash["JT"] = [af, ar, ax, k, aj, at, am]
aj.film_actor_hash["JT"] = [af, ar, ax, k, ai, at, am]
at.film_actor_hash["JT"] = [af, ar, ax, k, ai, aj, am]
am.film_actor_hash["JT"] = [af, ar, ax, k, ai, aj, at]
p.film_actor_hash["JU"] = [o, q, an, l, e, n]
o.film_actor_hash["JU"] = [p, q, an, l, e, n]
q.film_actor_hash["JU"] = [p, o, an, l, e, n]
an.film_actor_hash["JU"] = [p, o, q, l, e, n]
l.film_actor_hash["JU"] = [p, o, q, an, e, n]
e.film_actor_hash["JU"] = [p, o, q, an, l, n]
n.film_actor_hash["JU"] = [p, o, q, an, l, e]
u.film_actor_hash["JV"] = [al, ac, Kevin_Bacon, az, af]
al.film_actor_hash["JV"] = [u, ac, Kevin_Bacon, az, af]
ac.film_actor_hash["JV"] = [u, al, Kevin_Bacon, az, af]
Kevin_Bacon.film_actor_hash["JV"] = [u, al, ac, az, af]
az.film_actor_hash["JV"] = [u, al, ac, Kevin_Bacon, af]
af.film_actor_hash["JV"] = [u, al, ac, Kevin_Bacon, az]
k.film_actor_hash["JW"] = [d, ao, au, h, v]
d.film_actor_hash["JW"] = [k, ao, au, h, v]
ao.film_actor_hash["JW"] = [k, d, au, h, v]
au.film_actor_hash["JW"] = [k, d, ao, h, v]
h.film_actor_hash["JW"] = [k, d, ao, au, v]
v.film_actor_hash["JW"] = [k, d, ao, au, h]
h.film_actor_hash["JX"] = [ar, af, al, z, as]
ar.film_actor_hash["JX"] = [h, af, al, z, as]
af.film_actor_hash["JX"] = [h, ar, al, z, as]
al.film_actor_hash["JX"] = [h, ar, af, z, as]
z.film_actor_hash["JX"] = [h, ar, af, al, as]
as.film_actor_hash["JX"] = [h, ar, af, al, z]
t.film_actor_hash["JY"] = [d, ar, y, u, ab]
d.film_actor_hash["JY"] = [t, ar, y, u, ab]
ar.film_actor_hash["JY"] = [t, d, y, u, ab]
y.film_actor_hash["JY"] = [t, d, ar, u, ab]
u.film_actor_hash["JY"] = [t, d, ar, y, ab]
ab.film_actor_hash["JY"] = [t, d, ar, y, u]
av.film_actor_hash["JZ"] = [ab, w, h, ag, q, ad, aq]
ab.film_actor_hash["JZ"] = [av, w, h, ag, q, ad, aq]
w.film_actor_hash["JZ"] = [av, ab, h, ag, q, ad, aq]
h.film_actor_hash["JZ"] = [av, ab, w, ag, q, ad, aq]
ag.film_actor_hash["JZ"] = [av, ab, w, h, q, ad, aq]
q.film_actor_hash["JZ"] = [av, ab, w, h, ag, ad, aq]
ad.film_actor_hash["JZ"] = [av, ab, w, h, ag, q, aq]
aq.film_actor_hash["JZ"] = [av, ab, w, h, ag, q, ad]

node_array = [a,b,c,d,e,f,g,h,i,j,k,l,m,m,o,p,q,r,s,t,u,v,w,x,y,z,aa,ab,ac,ad,ae,af,ag,ah,ai,aj,ak,al,am,an,ao,ap,aq,ar,as,at,au,av,aw,ax,ay,az]

# end test environment setup

node_array.each do |x|
  find_kevin_bacon(x)
end
