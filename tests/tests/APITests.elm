module APITest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import API 


type Msg 
    = GetEmptyCompleted (Result Error ())

suite : Test
suite =
    describe "Test interoperability with webrpc-test reference server" 
        [ test "'getEmpty()' should get empty type successfully" <|
            \() ->
                API.testApi.getEmpty
                    |> Api.send GetEmptyCompleted
                
                Expect.equal "Hello, World!" (String.concat [ "Hello", ", ", "World", "!" ])

        ]



