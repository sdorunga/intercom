# Summary

- I chose to go with the recursive version of this because it looked to me to be
 the most readable version. Because this version is not tail recursive it will 
eventually blow the stack if the array nesting is deep enough. I've chosen to 
not implement it in a tail recursive way because firstly I have no insight on 
what kind of data this function will be used (which could mean this is good 
enough so I don't want to optimize too early), as well as the fact that, in Ruby,
 there is no Tail Call Optimization on by default so the interpreter won't 
optimize the calls. The iterative solution is likely to be significantly more 
performant and to use less memory but again, not knowing any of the performance 
requirements I chose the simplest solution and to not benchmark until I see an 
actual bottleneck.

- This version uses ruby refinements to give a convenient way of enhancing the 
default interface of Arrays in Ruby. In any class that needs to flatten a 
multi-level nested array the only thing needed is to include the refinements by 
`using ArrayRefinements` in their code. This way you get the convenience of 
having the method available on actual arrays without globally polluting the 
interface of all Arrays. It also means I can avoid having to do most validation 
on inputs because the method only applies to only Array objects.

- The method is named `flatten_nested` because Ruby already implements the method `flatten` on Arrays by default. I would have
preferred that name if it were available.

# Usage

You can try out the code in IRB. Run

`irb -r ./lib/array_refinement.rb`

to load the required module.

Because of a limitation in IRB you can not use refinements at the top level so you'll have to use a class to wrap the behaviour.

```
class TestFlatten
  using ArrayRefinements
  def flatten(array)
    array.flatten_nested
  end
end
```

Then you can use an instace of `TestFlatten` to flatten arrays.

```
test_flatten = TestFlatten.new

test_flatten.flatten([1,2,[3,[4]]])
```

This should return a flattened array.

# Running the tests

To run the tests, first install the dependencies

`bundle install`

Then run rspec to execue the tests

`bundle exec rspec`

