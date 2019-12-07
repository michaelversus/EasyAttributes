import XCTest
import EasyAttributes

class FontsTests: XCTestCase {
    
    func testValidURL() {
        // This is an example of a functional test case.
        let url = Bundle.main.url(forResource: "Fonts", withExtension: "plist")
        Fonts.registerPlist(url: url!)
        XCTAssertNotNil(Fonts._shared)
        XCTAssertEqual(Fonts.shared.fonts, ["pr": "PermanentMarker-Regular"])
    }
    
}
