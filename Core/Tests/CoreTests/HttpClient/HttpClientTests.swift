import Testing
@testable import Core
import XCTest

final class HttpClientTests: XCTestCase {
    
    func test_httpClient_unexpectedURLResponse() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeUnexpectedURLResponse))
        let expectation = expectation(description: "Unexpected response")
        
        do {
            _ = try await client.request(MockRequest(), decodingModel: Person.self)
        } catch {
            if case .unexpectedURLResponse = error {
                expectation.fulfill()
                XCTAssertEqual(error.description, "There was an unexpected response from the network request.")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_httpClient_decodingModelParsesSuccessfully() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeValidData))
        let person = try await client.request(MockRequest(), decodingModel: Person.self)
        
        XCTAssertEqual(person.name, "Foo")
    }
    
    func test_httpClient_decodingError() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeCorruptData))
        let expectation = expectation(description: "Decoding failure")
        
        do {
            _ = try await client.request(MockRequest(), decodingModel: Person.self)
        } catch {
            if case .decodingFailure = error {
                expectation.fulfill()
                XCTAssertEqual(error.description, "The data received from the network request could not be decoded.\nReason: The data couldn’t be read because it isn’t in the correct format.")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_httpClient_unexpectedStatusCode() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeUnexpectedStatusCode))
        let expectation = expectation(description: "Unexpected status code")
        
        do {
            _ = try await client.request(MockRequest(), decodingModel: Person.self)
        } catch {
            if case .unexpectedStatusCodeReceived = error {
                expectation.fulfill()
                XCTAssertEqual(error.description, "There was an unexpected status code that was received from the network request.\nHTTP status code was 404.")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_httpClient_urlError() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeURLError))
        let expectation = expectation(description: "URL error")
        
        do {
            _ = try await client.request(MockRequest(), decodingModel: Person.self)
        } catch {
            if case .urlError = error {
                expectation.fulfill()
                XCTAssertEqual(error.description, "There was an error in the network request.\nReason: The operation couldn’t be completed. (NSURLErrorDomain error -1009.)")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
    
    func test_httpClient_unknownError() async throws {
        let client = HttpClient(session: MockURLSession(condition: .makeUnknownError))
        let expectation = expectation(description: "URL error")
        
        do {
            _ = try await client.request(MockRequest(), decodingModel: Person.self)
        } catch {
            if case .unknownError = error {
                expectation.fulfill()
                XCTAssertEqual(error.description, "There was an unknown error in the network request.\nReason: The operation couldn’t be completed. (CoreTests.UnknownError error 0.)")
            }
        }
        
        await fulfillment(of: [expectation], timeout: 0.1)
    }
}
