//
//  PhotoListView.swift
//  PlanetConcurrency
//
//  Created by Antonio Iacono on 31/03/22.
//


import SwiftUI

struct PhotoListView: View {
    
    @StateObject var vm = PhotoListViewModel(/*forPreview: true*/)
    var body: some View {
        NavigationView{
            GeometryReader(){ geometry in
                List {
                    ForEach(vm.photos) { photo in
                        VStack() {
                            Text(photo.title)
                                .font(.headline)
                            
                            AsyncImage(url: URL(string: photo.url)){image in
                                image.resizable()
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 380, height: 380,alignment: .center)
                            .cornerRadius(50.0)
                        }
                        Spacer()
                    }
                }  .overlay(content: {
                    if vm.isLoading {
                        ProgressView()
                    }
                })
                    .alert("Application Error", isPresented: $vm.showAlert, actions: {
                        Button("OK") {}
                    }, message: {
                        if let errorMessage = vm.errorMessage {
                            Text(errorMessage)
                        }
                    })
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    .navigationTitle("Planets")
                    .navigationBarTitleDisplayMode(.inline)
                    .listStyle(.plain)
                    .task {
                        await vm.fetchPhoto()
                    }
            }
        }
        .refreshable{
            await vm.fetchPhoto()
        }
    }
}


struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}

