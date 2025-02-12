(*
   Unit tests for Pcre_settings
*)

let test_match_limit_ok () =
  let rex = Pcre_settings.regexp "(a+)+$" in
  try ignore (Pcre.pmatch ~rex "aaaaaaaaaaaaaaaaaaa!")
  with Pcre.Error Pcre.MatchLimit ->
    Alcotest.fail "should not have failed with error MatchLimit"

let test_match_limit_fail () =
  let rex = Pcre_settings.regexp "(a+)+$" in
  try
    ignore (Pcre.pmatch ~rex "aaaaaaaaaaaaaaaaaaaaaaaaaa!");
    Alcotest.fail "should have failed with error MatchLimit"
  with Pcre.Error Pcre.MatchLimit -> ()

let test_register_exception_printer () =
  (* This is a little dirty since we can't undo it. *)
  Pcre_settings.register_exception_printer ();

  let msg =
    try
      ignore (Pcre_settings.regexp "???");
      Alcotest.fail "should have failed to compile the regexp"
    with e -> Printexc.to_string e
  in
  Alcotest.(check string)
    "equal" "Pcre.Error(Pcre.BadPattern(\"nothing to repeat\", pos=0))" msg

let tests =
  Testutil.pack_tests "pcre settings"
    [
      ("match limit ok", test_match_limit_ok);
      ("match limit fail", test_match_limit_fail);
      ("exception printer", test_register_exception_printer);
    ]
