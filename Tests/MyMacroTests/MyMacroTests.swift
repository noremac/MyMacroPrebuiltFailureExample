#if canImport(MyMacroMacros)
import MyMacroMacros
import MacroTesting
import SnapshotTesting
import Testing

@Suite(.macros([StringifyMacro.self], record: .failed))
struct MyMacroTests {
  @Test
  func testMacro() {
    assertMacro {
      """
      #stringify(a + b)
      """
    } expansion: {
      """
      (a + b, "a + b")
      """
    }
  }

  @Test
  func testMacroWithStringLiteral() {
    assertMacro {
      #"""
      #stringify("Hello, \(name)")
      """#
    } expansion: {
      #"""
      ("Hello, \(name)", #""Hello, \(name)""#)
      """#
    }
  }
}
#endif
