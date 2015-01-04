module Examples.Optic.Records.Types where

  data Designation = Avenue
                   | Boulevard
                   | Circle
                   | Drive
                   | Street
                   | Way

  instance showDesignation :: Show Designation where
    show Avenue    = "Avenue"
    show Boulevard = "Boulevard"
    show Circle    = "Circle"
    show Drive     = "Drive"
    show Street    = "Street"
    show Way       = "Way"

  data State = AL
             | AK
             | AZ
             | AR
             | CA
             | CO
             | CT
             | DE
             | FL
             | GA
             | HI
             | ID
             | IL
             | IN
             | IA
             | KS
             | KY
             | LA
             | ME
             | MD
             | MA
             | MI
             | MN
             | MS
             | MO
             | MT
             | NE
             | NV
             | NH
             | NJ
             | NM
             | NY
             | NC
             | ND
             | OH
             | OK
             | OR
             | PA
             | RI
             | SC
             | SD
             | TN
             | TX
             | UT
             | VT
             | VA
             | WA
             | WV
             | WI
             | WY

  instance showState :: Show State where
    show AL = "AL"
    show AK = "AK"
    show AZ = "AZ"
    show AR = "AR"
    show CA = "CA"
    show CO = "CO"
    show CT = "CT"
    show DE = "DE"
    show FL = "FL"
    show GA = "GA"
    show HI = "HI"
    show ID = "ID"
    show IL = "IL"
    show IN = "IN"
    show IA = "IA"
    show KS = "KS"
    show KY = "KY"
    show LA = "LA"
    show ME = "ME"
    show MD = "MD"
    show MA = "MA"
    show MI = "MI"
    show MN = "MN"
    show MS = "MS"
    show MO = "MO"
    show MT = "MT"
    show NE = "NE"
    show NV = "NV"
    show NH = "NH"
    show NJ = "NJ"
    show NM = "NM"
    show NY = "NY"
    show NC = "NC"
    show ND = "ND"
    show OH = "OH"
    show OK = "OK"
    show OR = "OR"
    show PA = "PA"
    show RI = "RI"
    show SC = "SC"
    show SD = "SD"
    show TN = "TN"
    show TX = "TX"
    show UT = "UT"
    show VT = "VT"
    show VA = "VA"
    show WA = "WA"
    show WV = "WV"
    show WI = "WI"
    show WY = "WY"
