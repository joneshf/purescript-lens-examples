module Examples.Optic.Records where

  {-
      This module provides the canonical use of lenses,
      i.e. nested data structures.
  -}

  import Data.String (joinWith)

  import Examples.Optic.Records.Types

  import Optic.Core

  newtype Person = Person
    { firstName :: String
    , lastName  :: String
    , address   :: Address
    }

  newtype Address = Address
    { street :: StreetRec
    , city   :: String
    , state  :: State
    }

  newtype StreetRec = StreetRec
    { number      :: Number
    , streetName  :: String
    , designation :: Designation
    }

  runPerson (Person p) = p
  runAddress (Address a) = a
  runStreetRec (StreetRec s) = s

  instance showPerson :: Show Person where
    show (Person p) = "Person "
                   ++ "{firstName: " ++ show p.firstName
                   ++ ", lastName: " ++ show p.lastName
                   ++ ", address: " ++ show p.address
                   ++ "}"

  instance showAddress :: Show Address where
    show (Address a) = "Address "
                    ++ "{street: " ++ show a.street
                    ++ ", city: " ++ show a.city
                    ++ ", state: " ++ show a.state
                    ++ "}"

  instance showStreetRec :: Show StreetRec where
    show (StreetRec s) = "StreetRec "
                    ++ "{number: " ++ show s.number
                    ++ ", streetName: " ++ show s.streetName
                    ++ ", designation: " ++ show s.designation
                    ++ "}"

  johnDoe :: Person
  johnDoe = Person
    { firstName: "John"
    , lastName: "Doe"
    , address: Address
        { street: StreetRec
            { number: 1234
            , streetName: "Main"
            , designation: Street
            }
        , city: "AnyTown"
        , state: CA
        }
    }

  -- Updating fields without lenses.

  -- Very nice clean syntax for one layer of nesting.
  changeFirstName :: String -> Person -> Person
  changeFirstName newName (Person p) = Person p{firstName = newName}

  -- Starts to get a but hard to understand what is going on here.
  changeState :: State -> Person -> Person
  changeState newState (Person p) =
    Person p{address = Address (runAddress p.address){state = newState}}

  -- Very convoluted.
  changeStreetNumber :: Number -> Person -> Person
  changeStreetNumber newNumber (Person p) =
    Person p{address = Address addr{street = StreetRec strt{number = newNumber}}}
    where
      addr = runAddress p.address
      strt = runStreetRec addr.street

  -- Updating fields with lenses.

  -- Seems a bit much for just one layer of nesting.
  changeFirstNameLens :: String -> Person -> Person
  changeFirstNameLens = set (_Person..firstName)

  -- But this extends well.
  changeStateLens :: State -> Person -> Person
  changeStateLens = set (_Person..address.._Address..state)

  -- And stays flat, rather than getting too nested.
  changeStreetNumberLens :: Number -> Person -> Person
  changeStreetNumberLens = set (_Person..address.._Address..street.._StreetRec..number)

  -- We can use either of these ways to access data.
  janeDoe = changeFirstName "Jane" johnDoe
  janeDoeLens = changeFirstNameLens "Jane" johnDoe

  moveToAlaska = changeState AK johnDoe
  moveToAlaskaLens = changeStateLens AK johnDoe

  downTheStreet = changeStreetNumber 4321 johnDoe
  downTheStreetLens = changeStreetNumberLens 4321 johnDoe

  -- Getters and Setters.

  -- We can define a `Getter`,
  -- which can only be used to "get" a value from a data structure.

  -- Here we do some pretty formatting to create a "fullName" `Getter`.
  fullName :: Getter Person String
  fullName f p'@(Person p) = f (p.firstName ++ " " ++ p.lastName) <#> const p'

  -- Here we do some pretty formatting to create a "street address" `Getter`.
  prettyStreet :: Getter Person String
  prettyStreet f p'@(Person p) = f (joinWith " " viewed) <#> const p'
    where
      -- Since each lens is just a plain old function,
      -- we can pass them around like any other function
      strt = address.._Address..street.._StreetRec
      -- We can continue composing lenses.
      lenses = [ strt..number..to show
               , strt..streetName
               , strt..designation..to show
               ]
      -- And then finally use them just like any other value.
      -- Here we map over the list of lenses and view each one on `p`
      viewed = (^.) p <$> lenses

  -- Since `prettyStreet` is a `Getter`, this will work fine.
  foo :: String
  foo = johnDoe ^. prettyStreet
  -- But, this is a compile time error.
  -- bar :: Person
  -- bar = johnDoe # prettyStreet .~ ""

  -- We can also define `Setter`s,
  -- which can only be used to "set" a value in a data structure.
  setFirstName :: SetterP Person String
  setFirstName f (Person p) = f p.firstName <#> \n -> Person p{firstName = n}

  -- So this will work fine
  watDoe :: Person
  watDoe = johnDoe # setFirstName ++~ " wat "
  -- But this is a compile time error
  -- nope :: String
  -- nope = johnDoe ^. setFirstName

  -- Lenses

  _Person :: LensP Person {firstName :: String, lastName :: String, address :: Address}
  _Person f (Person b) = Person <$> f b

  _Address :: LensP Address {street :: StreetRec, city :: String, state :: State}
  _Address f (Address b) = Address <$> f b

  _StreetRec :: LensP StreetRec {number :: Number, streetName :: String, designation :: Designation}
  _StreetRec f (StreetRec b) = StreetRec <$> f b

  firstName :: forall b a r. Lens {firstName :: a | r} {firstName :: b | r} a b
  firstName f o = f o.firstName <#> \firstName' -> o{firstName = firstName'}

  lastName :: forall b a r. Lens {lastName :: a | r} {lastName :: b | r} a b
  lastName f o = f o.lastName <#> \lastName' -> o{lastName = lastName'}

  address :: forall b a r. Lens {address :: a | r} {address :: b | r} a b
  address f o = f o.address <#> \address' -> o{address = address'}

  street :: forall b a r. Lens {street :: a | r} {street :: b | r} a b
  street f o = f o.street <#> \street' -> o{street = street'}

  city :: forall b a r. Lens {city :: a | r} {city :: b | r} a b
  city f o = f o.city <#> \city' -> o{city = city'}

  state :: forall b a r. Lens {state :: a | r} {state :: b | r} a b
  state f o = f o.state <#> \state' -> o{state = state'}

  number :: forall b a r. Lens {number :: a | r} {number :: b | r} a b
  number f o = f o.number <#> \number' -> o{number = number'}

  streetName :: forall b a r. Lens {streetName :: a | r} {streetName :: b | r} a b
  streetName f o = f o.streetName <#> \streetName' -> o{streetName = streetName'}

  designation :: forall b a r. Lens {designation :: a | r} {designation :: b | r} a b
  designation f o = f o.designation <#> \designation' -> o{designation = designation'}
