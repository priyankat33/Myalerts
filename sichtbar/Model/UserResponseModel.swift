//
//  UserResponseModel.swift
//  SubzFresh
//
//  Created by Developer on 11/04/22.
//

import Foundation
struct UserResponseModel:Mappable {
   let status:Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
      
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
    }
}
struct SignUpResponseModel:Mappable {
   let status:Int?
    let message : String?
    let data:SignUpNewModel?
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(SignUpNewModel.self, forKey: .data)
    }
}

struct UserResponseModel1:Mappable {
   let status:Int?
    let message : String?
    let data:ForgotModel?
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(ForgotModel.self, forKey: .data)
    }
}


struct SignUpNewModel:Mappable {
   
    let userId:Int?
   
    enum CodingKeys: String, CodingKey {
       
        case userId = "user_id"
        
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        userId =   try values.decodeIfPresent(Int.self, forKey: .userId)
       
    }
}

struct ForgotModel:Mappable {
   
    let userId:String?
    let firstName,lastname,email:String?
    enum CodingKeys: String, CodingKey {
       
        case userId = "id"
        case firstName =  "firstname"
        case lastname = "lastname"
        case email = "email"
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        userId =   try values.decodeIfPresent(String.self, forKey: .userId)
        firstName =   try values.decodeIfPresent(String.self, forKey: .firstName)
        lastname = try values.decodeIfPresent(String.self, forKey: .lastname)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
}

struct PlanModel: Mappable {
   
   
    var package_id:String?
    enum CodingKeys: String, CodingKey {
       
        case package_id = "package_id"
       
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        //package_id =   try values.decodeIfPresent(String.self, forKey: .package_id)
        do {
            let value = try values.decodeIfPresent(Int.self, forKey: .package_id)
            package_id = "\(value ?? 0)"
        } catch DecodingError.typeMismatch {
            package_id = try values.decodeIfPresent(String.self, forKey: .package_id)
        }
       
    }
}

struct UserResponseModel2:Mappable {
   let status:Int?
    let message : String?
    let data:UserModel?
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(UserModel.self, forKey: .data)
    }
}

struct UserModel:Mappable {
   
    let firstName, lastName, email, profile_image,role_id,package,kpi_count,kpi_limit, agency_code:String?
    
    enum CodingKeys: String, CodingKey {
       
        case firstName = "firstname"
        case lastName = "lastname"
        case email,role_id,package,kpi_count,agency_code,kpi_limit
        case profile_image
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        firstName =   try values.decodeIfPresent(String.self, forKey: .firstName)
        kpi_limit =   try values.decodeIfPresent(String.self, forKey: .kpi_limit)
        agency_code =   try values.decodeIfPresent(String.self, forKey: .agency_code) ?? ""
        lastName =   try values.decodeIfPresent(String.self, forKey: .lastName)
        email =   try values.decodeIfPresent(String.self, forKey: .email)
        profile_image =   try values.decodeIfPresent(String.self, forKey: .profile_image)
        role_id =   try values.decodeIfPresent(String.self, forKey: .role_id)
        kpi_count =   try values.decodeIfPresent(String.self, forKey: .kpi_count)
        package =   try values.decodeIfPresent(String.self, forKey: .package)
    }
}


struct HomeResponseModel:Mappable {
   let status:Int?
    let message, package, notification_count : String?
    
    var data:[HomeModel] = [HomeModel]()
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case package = "package"
        case data = "data"
        case notification_count = "notification_count"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        package =   try values.decodeIfPresent(String.self, forKey: .package)
        notification_count =   try values.decodeIfPresent(String.self, forKey: .notification_count)
        guard let data =  try values.decodeIfPresent([HomeModel].self, forKey: .data) else{ return }
        self.data = data
        
    }
}


struct PlanResponseModel:Mappable {
   let status:Int?
    let message : String?
    let data:PlanModel?
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(PlanModel.self, forKey: .data)
    }
}

struct HomeModel:Mappable {
   
    let domain, kpi_title:String?
    let is_active,kpi_type,id,keyword,business_name, detail_link, kpi_name, kpi_icon_link, status_icon:String?
    let kpi_score: String?
    
    enum CodingKeys: String, CodingKey {
       case domain,is_active,id, kpi_type,keyword,business_name, detail_link, kpi_name, kpi_icon_link, kpi_score, status_icon, kpi_title
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        domain =   try values.decodeIfPresent(String.self, forKey: .domain)
        kpi_title =   try values.decodeIfPresent(String.self, forKey: .kpi_title)
        is_active =   try values.decodeIfPresent(String.self, forKey: .is_active)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        kpi_type = try values.decodeIfPresent(String.self, forKey: .kpi_type)
        kpi_icon_link = try values.decodeIfPresent(String.self, forKey: .kpi_icon_link)
        do {
            let value = try values.decodeIfPresent(Int.self, forKey: .kpi_score)
            kpi_score = "\(value ?? 0)"
        } catch DecodingError.typeMismatch {
            kpi_score = try values.decodeIfPresent(String.self, forKey: .kpi_score)
        }
        
        kpi_name = try values.decodeIfPresent(String.self, forKey: .kpi_name)
        keyword = try values.decodeIfPresent(String.self, forKey: .keyword)
        business_name = try values.decodeIfPresent(String.self, forKey: .business_name)
        detail_link = try values.decodeIfPresent(String.self, forKey: .detail_link)
        status_icon = try values.decodeIfPresent(String.self, forKey: .status_icon)
    }
}



struct TypeResponseModel:Mappable {
   let status:Int?
    let message : String?
    var data:[ TypeModel] = [TypeModel]()
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        
        guard let data =  try values.decodeIfPresent([TypeModel].self, forKey: .data) else{ return }
        self.data = data
        
    }
}


struct TypeModel:Mappable {
   
    let kpi_name,id:String?
    
    enum CodingKeys: String, CodingKey {
       
        case kpi_name,id
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        kpi_name =   try values.decodeIfPresent(String.self, forKey: .kpi_name)
        id =   try values.decodeIfPresent(String.self, forKey: .id)
        
        
    }
}


struct NotificationResponseModel:Mappable {
   let status:Int?
    let message : String?
    var data:[NotificationModel] = [NotificationModel]()
    enum CodingKeys: String, CodingKey {
       
        case message = "message"
        case status = "status"
        case data = "data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        status =   try values.decodeIfPresent(Int.self, forKey: .status)
        
        guard let data =  try values.decodeIfPresent([NotificationModel].self, forKey: .data) else{ return }
        self.data = data
        
    }
}

struct NotificationModel:Mappable {
   
    let title, created, message:String?
   
    enum CodingKeys: String, CodingKey {
       case title, created, message
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title =   try values.decodeIfPresent(String.self, forKey: .title)
        created =   try values.decodeIfPresent(String.self, forKey: .created)
        message =   try values.decodeIfPresent(String.self, forKey: .message)
        
    }
}
