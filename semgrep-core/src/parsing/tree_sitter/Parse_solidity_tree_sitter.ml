 (* Ferran Celades (@_fr0zn)
  *
  * Copyright (c) PUT YOUR COPYRIGHT HERE
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License (GPL)
  * version 2 as published by the Free Software Foundation.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * file license.txt for more details.
  *)
 (* module CST = Tree_sitter_solidity.CST *)
 module CST = Tree_sitter_rust.CST
 module H = Parse_tree_sitter_helpers
 module R = Parse_rust_tree_sitter

 (*****************************************************************************)
 (* Prelude *)
 (*****************************************************************************)
 (* Csharp parser using ocaml-tree-sitter-lang/charp and converting
  * directly to pfff/h_program-lang/AST_generic.ml
  *
  *)

 (*****************************************************************************)
 (* Helpers *)
 (*****************************************************************************)
type env = unit H.env
let _fake = AST_generic.fake
let token = H.token
let str = H.str

(*****************************************************************************)
(* Entry point *)
(*****************************************************************************)
let parse file = R.parse file

let parse_expression_or_source_file str =
  let res = Tree_sitter_rust.Parse.string str in
  match res.errors with
  | [] -> res
  | _ ->
      let expr_str = "__SEMGREP_EXPRESSION " ^ str in
      Tree_sitter_rust.Parse.string expr_str

(* todo: special mode to convert Ellipsis in the right construct! *)
let parse_pattern str = R.parse_pattern str