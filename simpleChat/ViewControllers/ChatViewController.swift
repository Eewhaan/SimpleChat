//
//  ChatViewController.swift
//  simpleChat
//
//  Created by Ivan Pavic on 4.3.22..
//


import UIKit
import SnapKit
import SendBirdSDK

protocol LastMessageDelegate: AnyObject {
    func updateLastMessage(_ message: SBDBaseMessage)
}


class ChatViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, SBDChannelDelegate {

    weak var delegate: SBDChannelDelegate?
    weak var lastMessageDelegate: LastMessageDelegate?

    
    
    var firstChannel = SBDOpenChannel()
    var messages = [SBDBaseMessage]()
    let userID = UIDevice.current.identifierForVendor?.uuidString

    
    var tableView: ChatTable!
    var sendButton: SendButton!
    var messageTextView: MessageTextView!
    var keyboardHeight = CGFloat(0)
    var heightConstraint = NSLayoutConstraint()
    var heightConstant = CGFloat(0) {
        didSet {
            heightConstraint.isActive = false
            heightConstraint = messageTextView.heightAnchor.constraint(equalToConstant: heightConstant)
            heightConstraint.isActive = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SBDMain.add(self, identifier: "ChatView")
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        setupViews()
        
        tableView.configureConstraints(superView: view, messageTextView: messageTextView)
        messageTextView.configureConstraints(tableView: tableView, sendButton: sendButton, superView: view)
        sendButton.configureConstraints(messageTextView: messageTextView, superView: view)
        
        textViewDidChange(messageTextView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        SBDOpenChannel.getWithUrl("sendbird_open_channel_32157_c677a5b1da71e3b322b2c7b57679621ea4220e98") { [weak self] openChannel, error in
            guard let openChannel = openChannel, error == nil else { return }
            self?.firstChannel = openChannel
            let listQuery = self?.firstChannel.createPreviousMessageListQuery()
            listQuery?.loadPreviousMessages(withLimit: 100, reverse: false) { messages, error in
                guard let messsages = messages, error == nil else { return }
                self?.messages = messsages
                self?.tableReloadAndScroll()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if messages[indexPath.row].isSentByMe() {
            if let sentCell = tableView.dequeueReusableCell(withIdentifier: "SentMessage", for: indexPath) as? SentMessage {
                sentCell.loadSetup()
                sentCell.messageLabel.text = messages[indexPath.row].message
                cell = sentCell
            }
        } else {
            if let recievedCell = tableView.dequeueReusableCell(withIdentifier: "RecievedMessage", for: indexPath) as? RecievedMessage {
            recievedCell.loadSetup()
            recievedCell.messageLabel.text = messages[indexPath.row].message
            cell = recievedCell
            }
        }
        return cell
    }
    
    func setupViews() {
        tableView = ChatTable()
        tableView.configure(delegate: self)
        view.addSubview(tableView)
        
        messageTextView = MessageTextView()
        messageTextView.configure()
        view.addSubview(messageTextView)
        
        sendButton = SendButton()
        sendButton.configure(target: self, action: #selector(sendMessage))
        view.addSubview(sendButton)
    }

    
    func textViewDidChange(_ textView: UITextView) {
        textView.delegate = self
        let height = textView.contentSize.height
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: height))
        heightConstant = min(newSize.height, 90)
        heightConstraint.isActive = true
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            messageTextView.remakeConstraints(keyboardShown: false, tableView: tableView, sendButton: sendButton, superView: view, keyboardHeight: keyboardViewEndFrame.height)
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        } else {
            messageTextView.remakeConstraints(keyboardShown: true, tableView: tableView, sendButton: sendButton, superView: view, keyboardHeight: keyboardViewEndFrame.height)
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
        
    }
    
    
    @objc func sendMessage(sender: UIButton) {
        guard let text = messageTextView.text else { return }
        if text == "" {
            return
        }
        firstChannel.sendUserMessage(text) { [weak self] userMessage, error in
            guard let userMessage = userMessage, error == nil else { return }
            self?.messages.append(userMessage)
            self?.tableReloadAndScroll()
        }
        messageTextView.text = nil
        textViewDidChange(messageTextView)
    }
    
    func tableReloadAndScroll() {
        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        lastMessageChanged()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        messageTextView.resignFirstResponder()
    }
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        messages.append(message)
        tableReloadAndScroll()
    }
    
    private func lastMessageChanged() {
        if let lastMessage = messages.last {
            lastMessageDelegate?.updateLastMessage(lastMessage)
        }
    }

}
