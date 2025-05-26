//
//  HomeView.swift
//  MovieBox
//
//  Created by Rabia Abdioğlu on 24.05.2025.
//
import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = MovieViewModel()
    @State private var isSearchActive: Bool = false
    @FocusState private var isSearchFieldFocused: Bool
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - Header Section
                HStack {
                    Text("Movies")
                        .font(Fonts.Title.mediumRegular)
                        .foregroundColor(Color.primary)
                        .opacity(isSearchActive ? 0 : 1)
                    
                    Spacer()
                    
                    // Show search field when search mode is active
                    if isSearchActive {
                        TextField("Search movies...", text: $viewModel.searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .focused($isSearchFieldFocused)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .textContentType(.none)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                            .onSubmit {
                                isSearchFieldFocused = false // Dismiss keyboard on submit
                            }
                    }
                    
                    Button {
                        withAnimation {
                            if isSearchActive && viewModel.searchText.isEmpty {
                                // Close search if field is empty
                                isSearchActive = false
                                isSearchFieldFocused = false
                            } else {
                                // Activate search and focus on text field
                                isSearchActive = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isSearchFieldFocused = true
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(Color.secondaryText)
                            .padding(.leading, 8)
                    }
                    
                    if !isSearchActive {
                        Image(systemName: "slider.horizontal.3")
                            .font(.system(size: 20))
                            .foregroundColor(Color.secondaryText)
                            .padding(.leading, 8)
                        
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 20))
                            .foregroundColor(Color.secondaryText)
                            .padding(.leading, 8)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 12)
                .background(
                    Color(.background)
                        .shadow(color: .secondaryBackground.opacity(0.09), radius: 2, x: 0, y: 2)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    // Close search if field is empty and user taps outside
                    if isSearchActive && viewModel.searchText.isEmpty {
                        withAnimation {
                            isSearchActive = false
                            isSearchFieldFocused = false
                        }
                    }
                }
                .frame(height: 70)
                
                // MARK: - Movie List Section
                
                if viewModel.isLoading {
                    
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.filteredMovies.isEmpty {
                    
                    EmptyResultView(imageName: "film", message: "No movies found")
                } else {
                    // Display grid of movie cards
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.filteredMovies) { movie in
                                NavigationLink(destination: MovieDetailView(viewModel: viewModel, movie: movie, isLiked: viewModel.likedMovieIDs.contains(movie.id))) {
                                    MovieCardView(movie: movie)
                                        .frame(height: 320)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                
                viewModel.fetchMovies()
                viewModel.fetchLikedMovieIDs()
            }
        }
    }
}
