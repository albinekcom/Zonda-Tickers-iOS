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
        
        XCTAssertEqual(3, Ticker.Name.kzcpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzcusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzceur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzcbtc.baseCurrencyNameLength)
            
        XCTAssertEqual(3, Ticker.Name.xrppln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xinpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xinusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xineur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xinbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xmrpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmrusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmreur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmrbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.zecpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zecusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zeceur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zecbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.gntpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gntusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gnteur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gntbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.omgpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ftopln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftousd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftoeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftobtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.reppln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.batpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.batusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bateur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.batbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.zrxpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.paypln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.payusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.payeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.paybtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.neupln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neuusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neueur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neubtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.trxpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(4, Ticker.Name.amltpln.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.amltusd.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.amlteur.baseCurrencyNameLength)
        XCTAssertEqual(4, Ticker.Name.amltbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.exypln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exyusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exyeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exybtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bobpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.lmlpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lmlbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xlmpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xlmusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xlmeur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xlmbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xbxbtc.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bcppln.baseCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bsvpln.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bsvusd.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bsveur.baseCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bsvbtc.baseCurrencyNameLength)
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
        
        XCTAssertEqual(3, Ticker.Name.kzcpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzcusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzceur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.kzcbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xrppln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xrpbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xinpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xinusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xineur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xinbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.xmrpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmrusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmreur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.xmrbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.zecpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zecusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zeceur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zecbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.gntpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gntusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gnteur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.gntbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.omgpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.omgbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.ftopln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftousd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftoeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.ftobtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.reppln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.repbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.batpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.batusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bateur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.batbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.zrxpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.zrxbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.paypln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.payusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.payeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.paybtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.neupln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neuusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neueur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.neubtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.trxpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.trxbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.amltpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.amltusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.amlteur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.amltbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.exypln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exyusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exyeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.exybtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.bobpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobusd.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobeur.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.bobbtc.counterCurrencyNameLength)
        
        XCTAssertEqual(3, Ticker.Name.lmlpln.counterCurrencyNameLength)
        XCTAssertEqual(3, Ticker.Name.lmlbtc.counterCurrencyNameLength)
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
