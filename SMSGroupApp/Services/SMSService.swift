import Foundation
import MessageKit

class SMSService {
    static let shared = SMSService()
    
    private init() {}
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        // 在实际设备上需要请求短信访问权限
        // 这里模拟权限请求
        completion(true)
    }
    
    func fetchAllMessages() -> [SMSMessage] {
        // 模拟短信数据
        return [
            SMSMessage(sender: "10086", content: "【中国移动】您的余额不足10元，请及时充值", date: Date()),
            SMSMessage(sender: "10010", content: "【中国联通】尊敬的客户，您已成功办理5G套餐", date: Date().addingTimeInterval(-3600)),
            SMSMessage(sender: "快递通知", content: "【顺丰速运】您的快递已到达菜鸟驿站", date: Date().addingTimeInterval(-7200)),
            SMSMessage(sender: "95588", content: "【工商银行】您的账户于1月10日支出1000.00元", date: Date().addingTimeInterval(-86400)),
            SMSMessage(sender: "12306", content: "【铁路客服】您购买的G1234次列车已发车", date: Date().addingTimeInterval(-172800)),
            SMSMessage(sender: "外卖", content: "【美团】您的外卖已送达，请及时取餐", date: Date().addingTimeInterval(-259200)),
            SMSMessage(sender: "验证码", content: "【阿里云】您的验证码是123456，10分钟内有效", date: Date().addingTimeInterval(-345600)),
        ]
    }
    
    func simulateNewMessage() -> SMSMessage {
        let randomSenders = ["10086", "10010", "快递通知", "95588", "12306", "外卖", "验证码"]
        let randomContents = [
            "【中国移动】您的话费余额已不足，请及时充值",
            "【中国联通】您的流量已使用80%，请注意使用",
            "【顺丰速运】您的快递正在派送中",
            "【工商银行】您的账户有新的交易记录",
            "【铁路客服】您的列车即将到站",
            "【美团】您的外卖正在制作中",
            "【腾讯云】您的验证码是789012"
        ]
        
        let randomIndex = Int.random(in: 0..<randomSenders.count)
        return SMSMessage(
            sender: randomSenders[randomIndex],
            content: randomContents[randomIndex],
            date: Date()
        )
    }
}