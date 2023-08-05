# Introduction

## Turing Machines (1936)

- infinite tape with data cells
- holding chars from finite alphabet
- read/write head
- state from finite set of states
- transition schedule:
  - given state and char read:
  - move to new state
  - write char to tape
  - move head left or right (or not)
  - or halt

## Lambda Calculus (1935)

- formal calculus to express computations
- based on:
  - function abstraction
  - function application
  - infinite set of variables
- driving principle of execution:
  - context-free substitution of expressions
  - towards a normal form (or fixed point)
- various variations:
  - typed vs untyped
  - pure vs applied
- invented by Alonzo Church
- Church-Turing Thesis:
  - Any effectively computable function is lambda-computable and Turing-computable
