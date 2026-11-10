open Type

let read_file path =
  let ic = open_in_bin path in
  let n = in_channel_length ic in
  let s = really_input_string ic n in
  close_in ic; s

let mnemonic line =
  match String.split_on_char ' ' (String.map (fun c -> if c = '\t' then ' ' else c) line) |> List.filter (( <> ) "") with
  | m :: _ -> m
  | [] -> ""

let () =
  let total = ref 0 and ok = ref 0 and unsupported = ref 0 and failed = ref 0 in
  let bad = Hashtbl.create 64 in
  let note m = Hashtbl.replace bad m (1 + Option.value ~default:0 (Hashtbl.find_opt bad m)) in
  let path = Sys.argv.(1) in
  Parser.Parser.preprocess (read_file path)
  |> List.iter (fun line ->
         if Isa_basic.IsaBasic.line_is_directive line || Isa_basic.IsaBasic.line_is_label line then ()
         else begin
           incr total;
           match Parser.Parser.parse_instr Isa_basic.IsaBasic.StrM.empty line with
           | _, (Parser.Parser.Isa.Unsupported _, _) -> incr unsupported; note (mnemonic line)
           | _ -> incr ok
           | exception _ -> incr failed; note (mnemonic line)
         end);
  let worst = Hashtbl.fold (fun m c acc -> (c, m) :: acc) bad [] |> List.sort compare |> List.rev in
  let top = List.filteri (fun i _ -> i < 12) worst |> List.map (fun (c, m) -> Printf.sprintf "%s:%d" m c) in
  Printf.printf "%s\t%d\t%d\t%d\t%d\t%d\t%s\n" (Filename.basename path) !total !ok !unsupported !failed
    (List.length worst) (String.concat " " top)
