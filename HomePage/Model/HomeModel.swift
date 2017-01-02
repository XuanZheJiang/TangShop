//
//  HomeModel.swift
//  Tang
//
//  Created by JGCM on 16/8/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import Foundation
import SwiftyJSON
class HomeModel{
    
    var contentUrl : String!
    var coverImageUrl : String!
    var createdAt : Int!
    var editorId : AnyObject!
    var id : Int!
    var labels : [AnyObject]!
    var liked : Bool!
    var likesCount : Int!
    var publishedAt : Int!
    var shareMsg : String!
    var shortTitle : String!
    var status : Int!
    var template : String!
    var title : String!
    var type : String!
    var updatedAt : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        contentUrl = json["content_url"].stringValue
        coverImageUrl = json["cover_image_url"].stringValue
        createdAt = json["created_at"].intValue
        editorId = json["editor_id"].stringValue as AnyObject!
        id = json["id"].intValue
        labels = [AnyObject]()
        let labelsArray = json["labels"].arrayValue
        for labelsJson in labelsArray{
            labels.append(labelsJson.stringValue as AnyObject)
        }
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        publishedAt = json["published_at"].intValue
        shareMsg = json["share_msg"].stringValue
        shortTitle = json["short_title"].stringValue
        status = json["status"].intValue
        template = json["template"].stringValue
        title = json["title"].stringValue
        type = json["type"].stringValue
        updatedAt = json["updated_at"].intValue
        url = json["url"].stringValue
    }
    
}
