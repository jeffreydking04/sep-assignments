class ActorNode
  attr_accessor :name
  attr_accessor :film_actor_hash

  def initialize(name)
    @name = name
    @film_actor_hash = {}
  end
end

# find_kevin_bacon does calls a helper method, fkb, that returns an array linking
# the argument actor to Kevin Bacon, if the connection exists, then it formats output
# to display the connection
def find_kevin_bacon(actor)
  # deal with Kevin Bacon as input
  if actor.name == "Kevin_Bacon"
    puts "Kevin Bacon:"
    puts "Nobody is closer to Kevin Bacon than Kevin Bacon."
    return
  end

  # call the 
  answer = fkb(actor)
  if !answer
    puts "There is either no connection between #{actor.name} and Kevin Bacon or the separation is greater than 6 degrees."
    return
  end

  # compute the degrees of separation
  degrees_of_separation = (answer.size - 1) / 2

  # pluralize degree appropriately (yes, I know there is a method for this, but it
  # was quicker to write this than look it up)
  if degrees_of_separation == 1
    degree = "degree"
  else
    degree = "degrees"
  end

  # output the degrees of separation and then cycle through the array, outputting
  # each edge and the resulting node
  puts "#{actor.name} is separated from Kevin Bacon by #{degrees_of_separation} #{degree}."
  puts "#{actor.name} was in:"
  (1...answer.size - 2).step(2).each do |x|
    puts "#{answer[x]} with #{answer[x + 1]} who was in:"
  end
  puts "#{answer[-2]} with Kevin Bacon."
end


# the real work is done here
def fkb(actor)
  # declare a hash to put each actor in
  # the hash will use the actor's name as the key 
  # the value will be an array containing the path from the given actor
  # to the hash actor
  actors_hash = {}

  # seed the hash with the given actor as key and his/her name in the array
  actors_hash[actor.name] = [actor.name]

  # create a FIFO array to queue the actors
  actors_array = [actor]

  # while there are still actors in the queue, keep searching for bacon
  while(actors_array[0])
    # return nil if the actor's path is already 6 degrees
    return if actors_hash[actors_array[0].name].size == 13

    # call the movies hash for th actor and cycle through
    actors_array[0].film_actor_hash.each do |film, actors|

      # cycle through actor that acted with the current actor in a given movie
      actors.each do |person|

        # if the actor has already been placed in the hash, then there is already
        # either a shorter connection to the actor given at the fkb call or one 
        # the same length, so we do not want to overwrite that path
        if !actors_hash.keys.include?(person.name)

          # if this the first time the actor has been encountered, we
          # we copy the path from the parameter actor to the actor who
          # first in the queue (actors_array[0]), the one we are currently
          # checking to see if he/she worked with bacon
          # We have to make a copy because Ruby does weird things with array
          # assignment.  There has to be a method for this.
          path = []
          actors_hash[actors_array[0].name].each do |x|
            path << x
          end

          # Then we push the film and the actor onto the path
          path << film
          path << person.name

          # and store it in the hash with the actor's name as key
          actors_hash[person.name] = path

          # finally, we push the actor onto the queue so we can search
          # the actors he or she has worked with if actors_array[0] did not 
          # work with bacon
          actors_array << person
        end

        # finally, we check to see if the actor is Kevin Bacon
        # the movie and Kevin Bacon have already been put in the path
        # so return it if we found bacon
        return path if person.name == "Kevin_Bacon"
      end
    end

    # dequeue the actor after all his/her films have been searched for bacon
    actors_array.delete_at(0)

    # the loop iterates as long as there are people to check
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
ba = ActorNode.new("ba")
bb = ActorNode.new("bb")
bc = ActorNode.new("bc")
bd = ActorNode.new("bd")
be = ActorNode.new("be")
bf = ActorNode.new("bf")
bg = ActorNode.new("bg")
bh = ActorNode.new("bh")
bi = ActorNode.new("bi")

Kevin_Bacon.film_actor_hash["movie1"] = [ba]
ba.film_actor_hash["movie1"] = [Kevin_Bacon]
ba.film_actor_hash["movie2"] = [bb]
bb.film_actor_hash["movie2"] = [ba]
bb.film_actor_hash["movie3"] = [bc]
bc.film_actor_hash["movie3"] = [bb]
bc.film_actor_hash["movie4"] = [bd]
bd.film_actor_hash["movie4"] = [bc]
bd.film_actor_hash["movie5"] = [be]
be.film_actor_hash["movie5"] = [bd]
be.film_actor_hash["movie6"] = [bf]
bf.film_actor_hash["movie6"] = [be]
bf.film_actor_hash["movie7"] = [bg]
bg.film_actor_hash["movie7"] = [bf]
bg.film_actor_hash["movie8"] = [bh]
bh.film_actor_hash["movie8"] = [bg]
bh.film_actor_hash["movie9"] = [bi]
bi.film_actor_hash["movie9"] = [bh]

aw.film_actor_hash["JA"] = [q, ax, ad, ac, Kevin_Bacon]
q.film_actor_hash["JA"] = [aw, ax, ad, ac, Kevin_Bacon]
ax.film_actor_hash["JA"] = [aw, q, ad, ac, Kevin_Bacon]
ad.film_actor_hash["JA"] = [aw, q, ax, ac, Kevin_Bacon]
ac.film_actor_hash["JA"] = [aw, q, ax, ad, Kevin_Bacon]
Kevin_Bacon.film_actor_hash["JA"] = [aw, q, ax, ad, ac]
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
aa.film_actor_hash["JE"] = [al, u, a, am, Kevin_Bacon]
al.film_actor_hash["JE"] = [aa, u, a, am, Kevin_Bacon]
u.film_actor_hash["JE"] = [aa, al, a, am, Kevin_Bacon]
a.film_actor_hash["JE"] = [aa, al, u, am, Kevin_Bacon]
am.film_actor_hash["JE"] = [aa, al, u, a, Kevin_Bacon]
Kevin_Bacon.film_actor_hash["JE"] = [aa, al, u, a, am]
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
Kevin_Bacon.film_actor_hash["JR"] = [d, ah, ar, ay, ak, af, ao]
d.film_actor_hash["JR"] = [Kevin_Bacon, ah, ar, ay, ak, af, ao]
ah.film_actor_hash["JR"] = [Kevin_Bacon, d, ar, ay, ak, af, ao]
ar.film_actor_hash["JR"] = [Kevin_Bacon, d, ah, ay, ak, af, ao]
ay.film_actor_hash["JR"] = [Kevin_Bacon, d, ah, ar, ak, af, ao]
ak.film_actor_hash["JR"] = [Kevin_Bacon, d, ah, ar, ay, af, ao]
af.film_actor_hash["JR"] = [Kevin_Bacon, d, ah, ar, ay, ak, ao]
ao.film_actor_hash["JR"] = [Kevin_Bacon, d, ah, ar, ay, ak, af]
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

# I created a random assortment of actors and films and ran each through
# the method with satisfactory results, though none was more than 2 degrees separated
# from bacon, so I created a few more actors and movies to deliberately simulate longer
# chains.  Here are the calls:
puts
find_kevin_bacon(Kevin_Bacon)
puts
find_kevin_bacon(ba)
puts
find_kevin_bacon(bb)
puts
find_kevin_bacon(bc)
puts
find_kevin_bacon(bd)
puts
find_kevin_bacon(be)
puts
find_kevin_bacon(bf)
puts
find_kevin_bacon(bg)
puts
find_kevin_bacon(bh)
puts
find_kevin_bacon(bi)
puts

# And here are the results:
#  
#  Kevin Bacon:
#  Nobody is closer to Kevin Bacon than Kevin Bacon.
#  
#  ba is separated from Kevin Bacon by 1 degree.
#  ba was in:
#  movie1 with Kevin Bacon.
#  
#  bb is separated from Kevin Bacon by 2 degrees.
#  bb was in:
#  movie2 with ba who was in:
#  movie1 with Kevin Bacon.
#  
#  bc is separated from Kevin Bacon by 3 degrees.
#  bc was in:
#  movie3 with bb who was in:
#  movie2 with ba who was in:
#  movie1 with Kevin Bacon.
#  
#  bd is separated from Kevin Bacon by 4 degrees.
#  bd was in:
#  movie4 with bc who was in:
#  movie3 with bb who was in:
#  movie2 with ba who was in:
#  movie1 with Kevin Bacon.
#  
#  be is separated from Kevin Bacon by 5 degrees.
#  be was in:
#  movie5 with bd who was in:
#  movie4 with bc who was in:
#  movie3 with bb who was in:
#  movie2 with ba who was in:
#  movie1 with Kevin Bacon.
#  
#  bf is separated from Kevin Bacon by 6 degrees.
#  bf was in:
#  movie6 with be who was in:
#  movie5 with bd who was in:
#  movie4 with bc who was in:
#  movie3 with bb who was in:
#  movie2 with ba who was in:
#  movie1 with Kevin Bacon.
#  
#  There is either no connection between bg and Kevin Bacon or the separation is greater than 6 degrees.
#  
#  There is either no connection between bh and Kevin Bacon or the separation is greater than 6 degrees.
#  
#  There is either no connection between bi and Kevin Bacon or the separation is greater than 6 degrees.
