# typed: true

class A < T::Struct
  prop :'foo', Integer
end

a = A.new(foo: 0)
a.foo = ''
