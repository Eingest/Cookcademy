//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Andreas Kiesel on 07.06.22.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction 
    }
    
    private let listBackGroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description)
                .listRowBackground(listBackGroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackGroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .listRowBackground(listBackGroundColor)
        }
        .foregroundColor(listTextColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        ModifyDirectionView(component: $emptyDirection) { _ in return }
    }
}
