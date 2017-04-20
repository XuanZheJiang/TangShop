//
//  SearchDetailModel.swift
//  Tang
//
//  Created by JGCM on 16/9/15.
//  Copyright © 2016年 xuanZheJiang. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchDetailModel{
    
    var authentic : AnyObject!
    var brandId : AnyObject!
    var brandOrder : Int!
    var categoryId : AnyObject!
    var commentsCount : Int!
    var coverImageUrl : String!
    var createdAt : Int!
    var descriptionField : String!
    var detailHtml : String!
    var editorId : Int!
    var favorited : Bool!
    var favoritesCount : Int!
    var id : Int!
    var imageUrls : [String]!
    var liked : Bool!
    var likesCount : Int!
    var name : String!
    var postIds : [AnyObject]!
    var price : String!
    var purchaseId : String!
    var purchaseStatus : Int!
    var purchaseType : Int!
    var purchaseUrl : String!
    var sharesCount : Int!
    var source : Source!
    var subcategoryId : AnyObject!
    var updatedAt : Int!
    var url : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == JSON.null {
            return
        }
        authentic = json["authentic"].stringValue as AnyObject!
        brandId = json["brand_id"].stringValue as AnyObject!
        brandOrder = json["brand_order"].intValue
        categoryId = json["category_id"].stringValue as AnyObject!
        commentsCount = json["comments_count"].intValue
        coverImageUrl = json["cover_image_url"].stringValue
        createdAt = json["created_at"].intValue
        descriptionField = json["description"].stringValue
        detailHtml = json["detail_html"].stringValue
        editorId = json["editor_id"].intValue
        favorited = json["favorited"].boolValue
        favoritesCount = json["favorites_count"].intValue
        id = json["id"].intValue
        imageUrls = [String]()
        let imageUrlsArray = json["image_urls"].arrayValue
        for imageUrlsJson in imageUrlsArray{
            imageUrls.append(imageUrlsJson.stringValue)
        }
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        name = json["name"].stringValue
        postIds = [AnyObject]()
        let postIdsArray = json["post_ids"].arrayValue
        for postIdsJson in postIdsArray{
            postIds.append(postIdsJson.stringValue as AnyObject)
        }
        price = json["price"].stringValue
        purchaseId = json["purchase_id"].stringValue
        purchaseStatus = json["purchase_status"].intValue
        purchaseType = json["purchase_type"].intValue
        purchaseUrl = json["purchase_url"].stringValue
        sharesCount = json["shares_count"].intValue
        let sourceJson = json["source"]
        if sourceJson != JSON.null{
            source = Source(fromJson: sourceJson)
        }
        subcategoryId = json["subcategory_id"].stringValue as AnyObject!
        updatedAt = json["updated_at"].intValue
        url = json["url"].stringValue
    }
    
}

class Source{
    
    var buttonTitle : String!
    var name : String!
    var pageTitle : String!
    var type : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == JSON.null {
            return
        }
        buttonTitle = json["button_title"].stringValue
        name = json["name"].stringValue
        pageTitle = json["page_title"].stringValue
        type = json["type"].stringValue
    }
    
}
