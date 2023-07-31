# Lambda Calculus

- any variable $x \in V$ is a $\lambda$-term
- if $x \in V$ and $e$ is a $\lambda$-term then $\lambda x.e$ is a λ-term $\rightarrow$ "function abstraction"
- if $e1$ and $e2$ are $\lambda$-terms then $(e1\ e2)$ is a $\lambda$-term ("function application") where $e1$ is the function and $e2$ is the argument.

## Bound Variables

- BV[x] = emptyset  | for any $x \in V$
- BV[λx.e] = {x} union BV[e] got any $x \in V$ and λ-term e
- BV[(e1 e2)] = BV[e1] union BV [e2]

## Free Variables


- FV[x] = {x}
- FV[λx.e] = FV[e] \ {x}
- FV[(e1 e2)] = FV[e1] union FV[e1]
- Example: FV[(x λx.(x y))] = {x,y}

## $\beta$-Reduction

### $\beta$-Redex

Let $\lambda x.e$ be a $\lambda$-term and let $a$ be a $\lambda$-term then
$(\lambda x.e\ a)$ is a ($\lambda$-term) β-redex

### $\beta$-Reduction

(λx.e a) ->β [e]_x^a

(λx.e a) ->β subst e x a (different notation for substitution)

describes the context-free substitution of all FREE occurrences of "x" in "e" by "a".

### Substitution

subst: L x V x L -> L where L is the set of λ-terms defined over set of variables V

subst x x a -> a

subst y x a -> y | y!=x

subst (e1 e2) x a -> ((subst e1 x a) (subst e2 x a))

subst λy.e x a -> λy.(subst e x a) | y!=x && y is not in FV[a]

subst λy.e x a -> λw.(subst (subst e y w) x a) | y!=x && y is in FV[a] && w is not in FV[a] && w is not in FV[e]

subst λy.e y a -> λy.e

### $\beta$-Reducibility

A λ-term $e_0$ is β-reducible to a λ-term e_n iff (sic!) there are λ-terms $e_1, \dots, e_{n-1}$

where $e_i \rightarrow \beta e_{i+1}$ for all $0\leq i<n$. We write $e_0 \rightarrow \beta^* e_n$.


## $\alpha$-Conversion

The naming of a bound variable is irrelevant:

$\lambda x.\lambda y.(x\ y)$

## Normal Form

A λ-term with no β-redex is said to be in normal form (NF).

If a λ-term e1 is β-reduceable to e2 and e2 is in NF then e2 is the NF of e1.

## Semantic Equivalence

Two λ-terms e1 and e2 are semantically equalivent if there is a sequence of β-reductions, inverse β-reductions and α-conversions that transform e1 into e2.

We write $[\![e1]\!] = [\![e2]\!]$  .

## Church-Rosser Theorem

Let $e_0, e_1, e_2$ be $\lambda$-terms.

If $e_0 \rightarrow \beta^* e_1$ and $e_0 \rightarrow \beta^* e_2$

then there is a $\lambda$-term $e_3$ with

$e_1 \rightarrow \beta^* e_3$ and $e_2 \rightarrow \beta^* e_3$.

In practical terms, the Church-Rosser Theorem says that any terminating reduction sequences lead to the very same normal form. So, it doesn't matter which beta-redex you choose for reduction, unless you take a route that does terminate.

## Reduction Order

### Leftmost-Innermost

Intuition: We select the leftmost redex that does not contain any further redex.

Formal definition:
| Formula | Comment |
|---|---|
|[[v]] = v||
|[[λv.e]] = λv.[[e]]||
|[[(λv.e a)]] = [[ subst e v [[a]] ]]| argument a is first evaluated|
|[[(e a)]] = [[ ([[e]] a) ]]'| perhaps evaluating the function term yields an actual function|
|[[(λv.e a)]]' = [[ subst e v [[a]] ]]| auxiliary definition needed to terminate reduction |
|[[(e a)]]' = (e [[a]])||

Commonly referred to as: "applicative order" or "eager evaluation"

Properties:
- arguments are evaluated *before* they are substituted into function bodies.
- may NOT find an existing NF
- efficient implementation
- intuitive reduction order
- terms quickly become smaller 

### Leftmost-Outermost

Intuition: We select the leftmost redex that is not part of another redex.

Formal definition:

| Formula | Comment |
|---|---|
|[[v]] = v||
|[[λv.e]] = λv.[[e]]||
|[[(λv.e a)]] = [[ subst e v a ]]| argument a is *not* evaluated|
|[[(e a)]] = [[ ([[e]] a) ]]'||
|[[(λv.e a)]]' = [[ subst e v a ]]||
|[[(e a)]]' = (e [[a]])| argument still must be evaluated|

Commonly referred to as: "normal order"

Properties:
- argument terms are substituted unevaluated into function bodies
- always finds NF if it exists ("strongly normalising")
- may have duplicate unevaluated terms and hence their evaluation
- may discard an argument term if the bound variable does not occur
  in the function body.
- the latter is the "trick" that makes normal order strongly normalizing

### Lazy Evaluation

Idea: Combine the strongly normalization property of normal order reduction with avoiding term (and hence evaluation) duplication.

So far, we have seen lambda-terms as character strings:

(λx.(x x) (((λu.λv.λw.(u v) w) a) b))

-> ( (((λu.λv.λw.(u v) w) a) b) (((λu.λv.λw.(u v) w) a) b) )
 
This is called "string reduction", no matter the strategy.

With lazy evaluation we do not substitute an unevaluated lambda-term into a function body but rather a reference to a single copy of said lambda-term:

(λx.(x x) (((λu.λv.λw.(u v) w) a) b))

-> (p p)

where p = (((λu.λv.λw.(u v) w) a) b)

This is now called "graph reduction".

When we further evaluate the above application, we first evaluate the function term, which is p. So, p is evaluated to normal form. Later, we evaluate the argument term, which again is p and at this point in time we automatically find already the normal form of the term pointed to.

Insight: All strongly normalizing programming languages use lazy evaluation, e.g. Haskell, Miranda, Clean.

