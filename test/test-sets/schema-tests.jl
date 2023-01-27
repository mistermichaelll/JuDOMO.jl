import JuDOMO: match_domo_types, create_dataset_schema
import JSON: json
import DataFrames: DataFrame
using Dates

## test sets for matching Julia's types to Domo's
types = [Int32, Int64, Float32, Float64, String, Dates.Date, Dates.DateTime]
expected_types = ["LONG", "LONG", "DOUBLE", "DOUBLE", "STRING", "DATE", "DATETIME"]

## test sets for schema creation
schema_test_mathematicians = Dict(
    "name" => "Leonhard Euler Party",
    "description" => "Mathematician guest list.",
    "rows" => 3,
    "schema" => Dict(
        "columns" => [Dict(
            "type" => "STRING",
            "name" => "Friend"
        ), Dict(
            "type" => "STRING",
            "name" => "Attending"
        )]
    )
) |> json

schema_test_mathematicians_dataset = DataFrame(
    "Friend" => ["Pythagoras", "Alan Turing", "George Boole"],
    "Attending" => ["TRUE", "TRUE", "FALSE"]
)

## test whether columns that contain null values are properly schema-d.
schema_test_nulls = Dict(
    "name" => "The Crows Outside My Apartment",
    "description" => "A partial list of friends.",
    "rows" => 5,
    "schema" => Dict(
        "columns" => [Dict(
            "type" => "STRING",
            "name" => "Friend"
        ), Dict(
            "type" => "STRING",
            "name" => "Visited"
        ), Dict(
            "type" => "LONG",
            "name" => "Approximate Peanuts Eaten"
        )]
    )
) |> json

null_schema_test_df = DataFrame(
    "Friend" => ["Peanut", "Cindy", missing, "Gumbo", "Flynn"],
    "Visited" => ["TRUE", missing, "FALSE", "TRUE", "FALSE"],
    "Approximate Peanuts Eaten" => [1, missing, missing, 3, 5]
)

create_dataset_schema(
        null_schema_test_df,
        "The Crows Outside My Apartment",
        "A partial list of friends."
    )
