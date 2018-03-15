//
//  Result.swift
//  Patreon
//
//  Created by Foti Dim on 15.03.18.
//  Copyright © 2018 FotiDim. All rights reserved.
//

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
