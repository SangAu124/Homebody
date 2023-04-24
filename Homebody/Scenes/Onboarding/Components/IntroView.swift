//
//  IntroView.swift
//  Homebody
//
//  Created by 김상금 on 2023/03/15.
//

import SwiftUI

struct IntroView: View {
    // MARK: - Animation Properties
    @State var showWalkThroughScreens: Bool = false
    @State var currentIndex: Int = 0
    @State var showHomeView: Bool = false
    
    var body: some View {
        ZStack {
            if showHomeView {
                MainView
                    .build()
                    .transition(.move(edge: .trailing))
            } else {
                ZStack {
                    Color(.white)
                        .ignoresSafeArea()
                    IntroScreen()
                    WalkThroughScreens()
                    NavBar()
                }
                .animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showHomeView)
    }
    
    // MARK: - WalkThrough Screens
    @ViewBuilder
    func WalkThroughScreens() -> some View {
        let isLast = currentIndex == intros.count
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(intros.indices, id: \.self) { index in
                    ScreenView(size: size, index: index)
                }
                WelcomView(size: size, index: intros.count)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // MARK: NextButton
            .overlay(alignment: .bottom) {
                // MARK: Converting Next Button Into Welcome Button
                ZStack {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .scaleEffect(!isLast ? 1 : 0.001)
                        .opacity(!isLast ? 1 : 0)
                    
                    HStack {
                        Text("시작하기")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "arrow.right")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 15)
                    .scaleEffect(isLast ? 1 : 0.001)
                    .frame(height: isLast ? nil : 0)
                    .opacity(isLast ? 1 : 0)
                }
                .frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
                .foregroundColor(.white)
                .background {
                    RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
                        .fill(Color("Primary_Orange"))
                }
                .onTapGesture {
                    // MARK: SignUp Action
                    if currentIndex == intros.count {
                        showHomeView = true
                    } else {
                        // MARK: Updating Index
                        currentIndex += 1
                    }
                }
                .offset(y: isLast ? -40 : -90)
            }
            .offset(y: showWalkThroughScreens ? 0: size.height)
            // Animation
            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
        }
    }
    
    @ViewBuilder
    func ScreenView(size: CGSize, index: Int) -> some View {
        let intro = intros[index]
        
        VStack(spacing: 10) {
            Text(intro.title)
                .font(.system(size: 27, weight: .bold))
            // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding Animation
            // MARK: Adding Delay to Elements based On Index
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.15 : 0), value: currentIndex)
            
            Text(intro.text)
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            
            Image(intro.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
            // MARK: Applying Offset For Each Screen's
                .offset(x: -size.width * CGFloat(currentIndex - index))
            // MARK: Adding Animation
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
        }
    }
    
    // MARK: - Welcom Screen
    @ViewBuilder
    func WelcomView(size: CGSize, index: Int) -> some View {
        VStack(spacing: 10) {
            Image("womanCalendar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250, alignment: .top)
                .padding(.horizontal, 20)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0 : 0.2).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
            Text("Homebody 시작하기")
                .font(.system(size: 27, weight: .bold))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(0.1).delay(currentIndex == index ? 0.2 : 0), value: currentIndex)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                
            
            Text("HomeBody는 로그인 없이 사용하실 수 있어요!")
                .font(.system(size: 14, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .offset(x: -size.width * CGFloat(currentIndex - index))
                .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay(currentIndex == index ? 0.2 : 0).delay(currentIndex == index ? 0.15 : 0), value: currentIndex)
        }
    }
    
    // MARK: - NavBar
    @ViewBuilder
    func NavBar() -> some View {
        let isLast = currentIndex == intros.count
        HStack {
            Button {
                // If Greater Than Zero Then Eliminating Index
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    showWalkThroughScreens.toggle()
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Primary_Brown"))
            }
            
            Spacer()
            
            Button("건너뛰기") {
                currentIndex = intros.count
            }
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color("Primary_Brown"))
            .opacity(isLast ? 0 : 1)
            .animation(.easeInOut, value: isLast)
        }
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .frame(maxHeight: .infinity, alignment: .top)
        .offset(y: showWalkThroughScreens ? 0 : -120)
    }
    
    @ViewBuilder
    func IntroScreen() -> some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 10) {
                Text("Homebody")
                    .font(.system(size: 27, weight: .bold))
                
                Text("집에만 있고 싶은 오늘, 'Homebody'로 확인해요!")
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Text("만나러 가기")
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 14)
                    .foregroundColor(.white)
                    .background {
                        Capsule()
                            .fill(Color("Primary_Orange"))
                    }
                    .onTapGesture {
                        showWalkThroughScreens.toggle()
                    }
                    .padding(.top, 70)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            // MARK: - Moving Up When Clicked
            .offset(y: showWalkThroughScreens ? -size.height : 0)
        }
        .ignoresSafeArea()
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
