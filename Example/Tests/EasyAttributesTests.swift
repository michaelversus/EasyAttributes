import XCTest
import EasyAttributes

class EasyAttributesTests: XCTestCase {
    
    func testValidURL() {
        // This is an example of a functional test case.
        EasyAttributes.configFonts()
        XCTAssertNotNil(Fonts._shared)
    }
    
}
