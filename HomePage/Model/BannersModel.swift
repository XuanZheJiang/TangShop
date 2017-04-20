
import Foundation
import SwiftyJSON

class BannersModel{

	var channel : String!
	var id : Int!
	var imageUrl : String!
	var order : Int!
	var status : Int!
	var target : Target!
	var targetId : Int!
	var targetUrl : String!
	var type : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
        if json == JSON.null {
            return
        }
		channel = json["channel"].stringValue
		id = json["id"].intValue
		imageUrl = json["image_url"].stringValue
		order = json["order"].intValue
		status = json["status"].intValue
		let targetJson = json["target"]
		if targetJson != JSON.null{
			target = Target(fromJson: targetJson)
		}
		targetId = json["target_id"].intValue
		targetUrl = json["target_url"].stringValue
		type = json["type"].stringValue
	}

}
