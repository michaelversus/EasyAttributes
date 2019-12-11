import XCTest
import EasyAttributes

class FontsTests: XCTestCase {
    
    func testValidURL() {
        // This is an example of a functional test case.
        let url = Bundle.main.url(forResource: "Fonts", withExtension: "plist")
        Fonts.register(fonts: ["pr":"PermanentMarker-Regular"])
        XCTAssertNotNil(Fonts._shared)
        XCTAssertEqual(Fonts.shared.fonts, ["pr": "PermanentMarker-Regular"])
    }
    
}
