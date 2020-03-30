//
//  ContentView.swift
//  PizzaApp
//
//  Created by Isc. Torres on 3/28/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showOrderSheet = false
    @FetchRequest(
        entity: Order.entity(),
        sortDescriptors:[
            NSSortDescriptor(key: "tableNumber", ascending: true)
        ],
        predicate: NSPredicate(format: "status != %@",Status.completed.rawValue)
        //predicate: NSPredicate(formart: "status != %@ AND tableNumber == %@",Status.completed.rawValue, 10)
    ) var orders:FetchedResults<Order>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(orders){ order in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(order.pizzaType) - \(order.numberOfSlices) slices")
                                .font(.headline)
                            Text("Table \(order.tableNumber)")
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {self.updateOrder(order: order)}){
                            Text(order.orderStatus == .pending ? "Prepare" : "Complete")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .onDelete{
                    indexSet in
                    for index in indexSet {
                        self.managedObjectContext.delete(self.orders[index])
                    }
                }
            }
            .navigationBarTitle("My Orders")
            .navigationBarItems(trailing: Button(
                action: { self.showOrderSheet = true },
                label: {
                    Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                }
            )) // END BUTTON
            .sheet(isPresented: $showOrderSheet){
                OrderSheet().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
    
    func updateOrder(order:Order){
        let newStatus = order.orderStatus == .pending ? Status.preparing : .completed
        managedObjectContext.performAndWait {
            order.orderStatus = newStatus
            try? managedObjectContext.save()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
