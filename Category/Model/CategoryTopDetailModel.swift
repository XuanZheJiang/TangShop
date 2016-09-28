//
//  CategoryTopDetailModel.swift
//  Tang
//
//  Created by JGCM on 16/8/17.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import Foundation
import SwiftyJSON
class CategoryTopDetailModel{
    
    var contentUrl : String!
    var coverImageUrl : String!
    var createdAt : Int!
    var id : Int!
    var labelIds : [AnyObject]!
    var liked : Bool!
    var likesCount : Int!
    var publishedAt : Int!
    var shareMsg : String!
    var shortTitle : String!
    var status : Int!
    var title : String!
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
        id = json["id"].intValue
        labelIds = [AnyObject]()
        let labelIdsArray = json["label_ids"].arrayValue
        for labelIdsJson in labelIdsArray{
            labelIds.append(labelIdsJson.stringValue as AnyObject)
        }
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        publishedAt = json["published_at"].intValue
        shareMsg = json["share_msg"].stringValue
        shortTitle = json["short_title"].stringValue
        status = json["status"].intValue
        title = json["title"].stringValue
        updatedAt = json["updated_at"].intValue
        url = json["url"].stringValue
    }
    
}
