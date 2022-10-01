# typed: true

class A
  extend T::Generic
  Elem = type_member

  # Renaming Elem to AnotherElem should take the slow path, because it should
  # show up as a change to a static field class alias (this should be the same
  # with static fields)

  AliasToElem = Elem
end
