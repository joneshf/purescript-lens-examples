# Module Documentation

## Module Examples.Optic.Records.Types

### Types

    data Designation where
      Avenue :: Designation
      Boulevard :: Designation
      Circle :: Designation
      Drive :: Designation
      Street :: Designation
      Way :: Designation

    data State where
      AL :: State
      AK :: State
      AZ :: State
      AR :: State
      CA :: State
      CO :: State
      CT :: State
      DE :: State
      FL :: State
      GA :: State
      HI :: State
      ID :: State
      IL :: State
      IN :: State
      IA :: State
      KS :: State
      KY :: State
      LA :: State
      ME :: State
      MD :: State
      MA :: State
      MI :: State
      MN :: State
      MS :: State
      MO :: State
      MT :: State
      NE :: State
      NV :: State
      NH :: State
      NJ :: State
      NM :: State
      NY :: State
      NC :: State
      ND :: State
      OH :: State
      OK :: State
      OR :: State
      PA :: State
      RI :: State
      SC :: State
      SD :: State
      TN :: State
      TX :: State
      UT :: State
      VT :: State
      VA :: State
      WA :: State
      WV :: State
      WI :: State
      WY :: State


### Type Class Instances

    instance showDesignation :: Show Designation

    instance showState :: Show State


## Module Examples.Optic.Records

### Types

    newtype Address where
      Address :: { state :: State, city :: String, street :: StreetRec } -> Address

    newtype Person where
      Person :: { address :: Address, lastName :: String, firstName :: String } -> Person

    newtype StreetRec where
      StreetRec :: { designation :: Designation, streetName :: String, number :: Number } -> StreetRec


### Type Class Instances

    instance showAddress :: Show Address

    instance showPerson :: Show Person

    instance showStreetRec :: Show StreetRec


### Values

    _Address :: LensP Address { state :: State, city :: String, street :: StreetRec }

    _Person :: LensP Person { address :: Address, lastName :: String, firstName :: String }

    _StreetRec :: LensP StreetRec { designation :: Designation, streetName :: String, number :: Number }

    address :: forall b a r. Lens { address :: a | r } { address :: b | r } a b

    changeFirstName :: String -> Person -> Person

    changeFirstNameLens :: String -> Person -> Person

    changeState :: State -> Person -> Person

    changeStateLens :: State -> Person -> Person

    changeStreetNumber :: Number -> Person -> Person

    changeStreetNumberLens :: Number -> Person -> Person

    city :: forall b a r. Lens { city :: a | r } { city :: b | r } a b

    designation :: forall b a r. Lens { designation :: a | r } { designation :: b | r } a b

    firstName :: forall b a r. Lens { firstName :: a | r } { firstName :: b | r } a b

    foo :: String

    fullName :: Getter Person String

    johnDoe :: Person

    lastName :: forall b a r. Lens { lastName :: a | r } { lastName :: b | r } a b

    number :: forall b a r. Lens { number :: a | r } { number :: b | r } a b

    prettyStreet :: Getter Person String

    setFirstName :: SetterP Person String

    state :: forall b a r. Lens { state :: a | r } { state :: b | r } a b

    street :: forall b a r. Lens { street :: a | r } { street :: b | r } a b

    streetName :: forall b a r. Lens { streetName :: a | r } { streetName :: b | r } a b

    watDoe :: Person


## Module Examples.Optic.Bounded

### Types

    newtype Ball where
      Ball :: { y :: Number, x :: Number } -> Ball

    type LowerBound = Number

    type UpperBound = Number


### Type Class Instances

    instance showBall :: Show Ball


### Values

    _Ball :: LensP Ball { y :: Number, x :: Number }

    clamp :: LowerBound -> UpperBound -> Number -> Number

    moveEast10 :: Ball -> Ball

    moveNorthEast130 :: Ball -> Ball

    moveSouth30 :: Ball -> Ball

    x :: forall r. LensP { x :: Number | r } Number

    y :: forall r. LensP { y :: Number | r } Number


## Module Examples.Optic.Virtual

### Types

    type CM = Number

    type Ft = Number

    type In = Number

    newtype Length where
      Length :: MM -> Length

    type M = Number

    type MM = Number


### Type Class Instances

    instance showLength :: Show Length


### Values

    _Length :: LensP _ _

    cm :: LensP Length CM

    feet :: LensP Length Ft

    inches :: LensP Length In

    m :: LensP Length M

    mm :: LensP Length MM

    tenmm :: Length

    threeInches :: Length

    unitLen :: Length


## Module Examples.Optic.Traversal

### Values

    foo :: [Tuple (Either Number (Maybe String)) (Maybe Boolean)]

    wat :: Tuple (Either Number (Maybe String)) (Maybe Boolean)



