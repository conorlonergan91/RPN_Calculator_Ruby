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
<b>Install as gem</b><br>
`gem install rpn-calculator`<br>
<br>
<b>Import into project</b><br>
 - Copy the file [rpn_calculator.rb](https://github.com/conorlonergan91/RPN_Calculator_Ruby/blob/master/rpn_calculator.rb)
into project.
 - Require the script using `require_relative 'RPN_Calculator'`
 - Include the mixin in your `Class` as shown below:
 ```
Class RPNClient
    include RPNCalculator
    # Do something
end
```
 - In a terminal window navigate to the project root directory and run `bundle install`

## Usage
This module support the following operations:
- <b>Single number operations:</b> sqrt sin cos tan
- <b>Two number operations:</b> + - * / **
 

The `parse_input` method takes an Array where each element in the array should 
be either an operator (see supported operators above) or an operand (integer or 
float).<br>
The order of operators and operands is important (refer to "How does an RPN 
calculator work?" above for guidance)  

If a valid expression then the resulting calculation will be returned, otherwise 
false will be returned.

<b>N.B.</b> The only method you should call is `parse_input`. The `_calculate` 
method is private and should be avoided as it is expecting input that is 
formatted and controlled by `parse_input`.

A client program [rpn_client.rb](https://github.com/conorlonergan91/RPN_Calculator_Ruby/blob/master/rpn_client.rb)
has been provided as an example implementation which solicits user input,
formats and handles the input appropriately, and then passes it to the 
`parse_input`. The response is then handled appropriately.

An rspec file has also been included in this repo [spec/rpn_calculator_spec.rb](https://github.com/conorlonergan91/RPN_Calculator_Ruby/blob/master/spec/rpn_calculator_spec.rb).
This can be run from the project's root directory using `rspec spec/rpn_calculator_spec.rb` 
provided the rspec gem is installed in your environment.

Two files launch_container.sh and save_image.sh are included just to showcase a
basic use of docker containers for this project. These simple scripts ensure
container environments stay up to date and that each container connects to a
shared local folder on my machine so files can easily be accessed and updated 
using RubyMine.

![IDE Screenshot][screenshot]

[screenshot]: https://github.com/conorlonergan91/RPN_Calculator_Ruby/blob/master/IDE_Screenshot.png "IDE Screenshot"

Developed for @Storyful Dublin
