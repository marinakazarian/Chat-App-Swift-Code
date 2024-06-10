//
//  ContactsListView.swift
//  swiftui-chat
//
//  Created by Marina Kazarian on 6/6/24.
//

import SwiftUI

struct ContactsListView: View {
    
    @EnvironmentObject var contactsViewModel: ContactsViewModel
    @EnvironmentObject var chatViewModel: ChatViewModel
    
    @Binding var isChatShowing: Bool
    @Binding var isSettingsShowing: Bool
    
    @State var filterText = ""
    
    var body: some View {
        
        VStack {
            // Heading
            HStack {
                Text("Contacts")
                    .font(Font.pageTitle)
                
                Spacer()
                
                Button {
                    isSettingsShowing = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(Color("icons-secondary"))
                }
                
            }
            .padding(.top, 20)
            
            // Search bar
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                
                TextField("Search contact or number", text: $filterText)
                    .font(Font.tabBar)
                    .foregroundColor(Color("text-textfield"))
                    .placeholder(when: filterText.isEmpty) {
                        Text("Search contact or number")
                            .foregroundColor(Color("text-textfield"))
                            .font(Font.bodyParagraph)
                    }
                    .padding()
            }
            .frame(height: 46)
            .onChange(of: filterText) { _ in
                // Filter the results
                contactsViewModel.filterContacts(filterBy:
                                                    filterText.lowercased()
                                                    .trimmingCharacters(in: .whitespacesAndNewlines))
            }
            
            if contactsViewModel.filteredUsers.count > 0 {
            
                // List
                List(contactsViewModel.filteredUsers) { user in
                    
                    // only show contact if active
                    if user.isactive {
                        Button {
                            
                            // Search for an existing convo with this user
                            // tapping on a single contact
                            chatViewModel.getChatFor(contacts: [user])
                            
                            // Display conversation view
                            isChatShowing = true
                            
                        } label: {
                            
                            // Display rows
                            ContactRow(user: user)
                        }
                        .buttonStyle(.plain)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    
                }
                .listStyle(.plain)
                .padding(.top, 12)
            }
            else {
                
                Spacer()
                
                Image("no-contacts-yet")
                
                Text("Hmm... Zero contacts?")
                    .font(Font.titleText)
                    .padding(.top, 32)
                
                Text("Try saving some contacts on your phone!")
                    .font(Font.bodyParagraph)
                    .padding(.top, 8)
                
                
                Spacer()
                
            }
            
        }
        .padding(.horizontal)

    }
}

struct ContactsListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView(isChatShowing: .constant(false), isSettingsShowing: .constant(false))
    }
}
