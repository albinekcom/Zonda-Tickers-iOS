import XCTest
@testable import BitBay_Ticker

final class TickerTests: XCTestCase {
    
    func testBaseCurrencyNameLength() {
        XCTAssertEqual(3, Ticker.Name.btcpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btcusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btceur.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ltcpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltcusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltceur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltcbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ethpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ethusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.etheur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ethbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.lskpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bccpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bccusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bcceur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bccbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(4, Ticker.Name.dashpln.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.dashusd.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.dasheur.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.dashbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(4, Ticker.Name.gamepln.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.gameusd.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.gameeur.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.gamebtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.btgpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgbtc.baseCurrencyNameLength)
    }
    
    func testCounterCurrencyNameLength() {
        XCTAssertEqual(3, Ticker.Name.btcpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btcusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btceur.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ltcpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltcusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltceur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ltcbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ethpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ethusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.etheur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ethbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.lskpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lskbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bccpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bccusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bcceur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bccbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.dashpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.dashusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.dasheur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.dashbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.gamepln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gameusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gameeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gamebtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.btgpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.btgbtc.counterCurrencyNameLength)
    }
    
    func testKeys() {
        XCTAssertEqual("name", Ticker.Key.name)
        XCTAssertEqual("max", Ticker.Key.max)
        XCTAssertEqual("min", Ticker.Key.min)
        XCTAssertEqual("last", Ticker.Key.last)
        XCTAssertEqual("bid", Ticker.Key.bid)
        XCTAssertEqual("ask", Ticker.Key.ask)
        XCTAssertEqual("vwap", Ticker.Key.vwap)
        XCTAssertEqual("average", Ticker.Key.average)
        XCTAssertEqual("volume", Ticker.Key.volume)
    }
    
    func testInitWithName() {
        let ticker = Ticker(name: .btcpln, jsonDictionary: nil)!
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual(Currency.btc, ticker.baseCurrency)
        XCTAssertEqual(Currency.pln, ticker.counterCurrency)
        XCTAssertNil(ticker.max)
        XCTAssertNil(ticker.min)
        XCTAssertNil(ticker.last)
        XCTAssertNil(ticker.bid)
        XCTAssertNil(ticker.ask)
        XCTAssertNil(ticker.vwap)
        XCTAssertNil(ticker.average)
        XCTAssertNil(ticker.volume)
    }
    
    func testInitWithNameAndJsonDictionary() {
        let jsonDictionary = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8
        ]
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: jsonDictionary)!
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual(Currency.btc, ticker.baseCurrency)
        XCTAssertEqual(Currency.pln, ticker.counterCurrency)
        XCTAssertEqual(1.1, ticker.max)
        XCTAssertEqual(2.2, ticker.min)
        XCTAssertEqual(3.3, ticker.last)
        XCTAssertEqual(4.4, ticker.bid)
        XCTAssertEqual(5.5, ticker.ask)
        XCTAssertEqual(6.6, ticker.vwap)
        XCTAssertEqual(7.7, ticker.average)
        XCTAssertEqual(8.8, ticker.volume)
    }
    
    func testInitFromDictionary() {
        let inputDictionary: [String: Any] = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8,
            "name": "btcpln"
        ]
        
        let ticker = Ticker(fromDictionary: inputDictionary)!
        
        XCTAssertEqual(Ticker.Name.btcpln, ticker.name)
        XCTAssertEqual(Currency.btc, ticker.baseCurrency)
        XCTAssertEqual(Currency.pln, ticker.counterCurrency)
        XCTAssertEqual(1.1, ticker.max)
        XCTAssertEqual(2.2, ticker.min)
        XCTAssertEqual(3.3, ticker.last)
        XCTAssertEqual(4.4, ticker.bid)
        XCTAssertEqual(5.5, ticker.ask)
        XCTAssertEqual(6.6, ticker.vwap)
        XCTAssertEqual(7.7, ticker.average)
        XCTAssertEqual(8.8, ticker.volume)
    }
    
    func testDictionary() {
        let jsonDictionary = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8
        ]
        
        let ticker = Ticker(name: .btcpln, jsonDictionary: jsonDictionary)!
        
        let expectedDictionary: [String: Any] = [
            "max": 1.1,
            "min": 2.2,
            "last": 3.3,
            "bid": 4.4,
            "ask": 5.5,
            "vwap": 6.6,
            "average": 7.7,
            "volume": 8.8,
            "name": "btcpln"
        ]
        
        XCTAssertEqual(expectedDictionary as NSDictionary, ticker.dictionary as NSDictionary)
    }
    
    func testPrettyName() {
        let ticker1 = Ticker(name: .btcpln, jsonDictionary: nil)!
        XCTAssertEqual("BTC/PLN", ticker1.prettyName)
        
        let ticker2 = Ticker(name: .etheur, jsonDictionary: nil)!
        XCTAssertEqual("ETH/EUR", ticker2.prettyName)
    }
    
    func testDifference() {
        let ticker1 = Ticker(fromDictionary: ["last": 3.3, "vwap": 6.6, "name": "btcpln"])!
        XCTAssertEqual(-3.3, ticker1.difference)
        
        let ticker2 = Ticker(fromDictionary: ["last": 3.3, "name": "btcpln"])!
        XCTAssertNil(ticker2.difference)
        
        let ticker3 = Ticker(fromDictionary: ["vwap": 6.6, "name": "btcpln"])!
        XCTAssertNil(ticker3.difference)
        
        let ticker4 = Ticker(fromDictionary: ["name": "btcpln"])!
        XCTAssertNil(ticker4.difference)
    }
    
    func testDifferenceRatio() {
        let ticker1 = Ticker(fromDictionary: ["last": 3.3, "vwap": 6.6, "name": "btcpln"])!
        XCTAssertEqual(-0.5, ticker1.differenceRatio)
        
        let ticker2 = Ticker(fromDictionary: ["last": 3.3, "name": "btcpln"])!
        XCTAssertNil(ticker2.differenceRatio)
        
        let ticker3 = Ticker(fromDictionary: ["vwap": 6.6, "name": "btcpln"])!
        XCTAssertNil(ticker3.differenceRatio)
        
        let ticker4 = Ticker(fromDictionary: ["name": "btcpln"])!
        XCTAssertNil(ticker4.differenceRatio)
    }
    
    func testDifferenceRatioInPercantage() {
        let ticker1 = Ticker(fromDictionary: ["last": 3.3, "vwap": 6.6, "name": "btcpln"])!
        XCTAssertEqual(-50, ticker1.differenceRatioInPercantage)
        
        let ticker2 = Ticker(fromDictionary: ["last": 3.3, "name": "btcpln"])!
        XCTAssertNil(ticker2.differenceRatioInPercantage)
        
        let ticker3 = Ticker(fromDictionary: ["vwap": 6.6, "name": "btcpln"])!
        XCTAssertNil(ticker3.differenceRatioInPercantage)
        
        let ticker4 = Ticker(fromDictionary: ["name": "btcpln"])!
        XCTAssertNil(ticker4.differenceRatioInPercantage)
    }
    
}
