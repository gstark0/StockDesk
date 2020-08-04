import SwiftUI

struct AddStock: View {
    @State private var query = ""
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search by symbol", text: $query)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(6)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button("Cancel") {
                    self.isEditing = false
                    self.query = ""
                }
                .padding(.trailing, 10)
            }
        }
    }
}

struct AddStock_Previews: PreviewProvider {
    static var previews: some View {
        AddStock()
    }
}
