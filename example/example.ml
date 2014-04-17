module Html = Dom_html

let onload _ =
  let text1 = "Je suis un lama" in
  let text2 = "Je suis vraiment lama" in
  let dmp = DiffMatchPatch.make () in
  let diff = DiffMatchPatch.diff_main dmp text1 text2 in
  let patch = DiffMatchPatch.patch_make dmp text1 diff in
  let result = DiffMatchPatch.patch_apply dmp patch text1 in
  print_endline result;
  Js._true

let _ = Html.window##onload <- Html.handler onload
