# RPN_Calculator_Ruby
<b>@author</b> Conor Lonergan<br>
## A Reverse Polish (Postfix) Notation Calculator mixin module in Ruby

### What is an RPN calculator
https://en.wikipedia.org/wiki/Reverse_Polish_notation<br>
RPN is a mathematical notation in which operators follow their operands.  It 
does not need any parentheses as long as each operator has a fixed number of 
operands.<br>

### How does an RPN calculator work?
In reverse Polish notation, the operators follow their operands; for instance, 
to add 3 and 4, one would write 3 4 + rather than 3 + 4. If there are multiple 
operations, operators are given immediately after their second operands; so the 
expression written 3 − 4 + 5 in conventional notation would be written 3 4 − 5 
+ in reverse Polish notation: 4 is first subtracted from 3, then 5 is added to 
it. An advantage of reverse Polish notation is that it removes the need for 
parentheses that are required by infix notation. While 3 − 4 × 5 can also be 
written 3 − (4 × 5), that means something quite different from (3 − 4) × 5. In 
reverse Polish notation, the former could be written 3 4 5 × −, which 
unambiguously means 3 (4 5 ×) − which reduces to 3 20 − (which can further be 
reduced to -17); the latter could be written 3 4 − 5 × (or 5 3 4 − ×, if keeping 
similar formatting), which unambiguously means (3 4 −) 5 ×.

## Installation
rpn_calculator.rb


Developed for @Storyful Dublin
