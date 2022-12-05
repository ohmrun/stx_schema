// class BUBALUB extends FileSystemBlockChain<String,DeclareSchema>{
//   static public function module():Cascade<HasDevice,BlockChain<String,DeclareSchema>,SchemaFailure>{
//     return __.asys().local().device.shell.cwd.pop()
//      .convert(
//       (dir:Directory) -> dir.into(['.sdb','stx','schema'])
//     ).reframe()
//      .commandment(Directory._.ensure)
//      .evaluation()
//      .broach()
//      .convert(
//       (couple:Couple<HasDevice,Directory>) -> 
//         couple.mapl(x->x.device).decouple(BlockChain.FileSystem.bind(BlockChainDeps.unit()))
//     ).errate(
//       e -> e.toASysFailure().toSchemaFailure()
//     );
//   }
// }