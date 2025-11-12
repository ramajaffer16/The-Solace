//
//  OnboardingVC.swift
//  DailyAyah
//
//  Created by Ramadhan on 12/11/2025.
//  Onboarding flow for first-time users
//

import UIKit

class OnboardingViewController: UIViewController {

    private let pages = OnboardingPage.pages
    private var currentPage = 0

    var onComplete: (() -> Void)?

    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.showsHorizontalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = OnboardingPage.pages.count
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor(named: "Forest")?.withAlphaComponent(0.3)
        pc.currentPageIndicatorTintColor = UIColor(named: "Forest")
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "PTSerif-Bold", size: 18)
        button.backgroundColor = UIColor(named: "Forest")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "PTSerif-Regular", size: 16)
        button.setTitleColor(UIColor(named: "Forest"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPages()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "Cream")

        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)

        scrollView.delegate = self

        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            scrollView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -30),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -30),

            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupPages() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for page in pages {
            let pageView = createPageView(for: page)
            stackView.addArrangedSubview(pageView)
        }

        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    private func createPageView(for page: OnboardingPage) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let emojiLabel = UILabel()
        emojiLabel.text = page.emoji
        emojiLabel.font = .systemFont(ofSize: 80)
        emojiLabel.textAlignment = .center
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = page.title
        titleLabel.font = UIFont(name: "PTSerif-Bold", size: 28)
        titleLabel.textColor = UIColor(named: "Forest")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let descriptionLabel = UILabel()
        descriptionLabel.text = page.description
        descriptionLabel.font = UIFont(name: "PTSerif-Regular", size: 18)
        descriptionLabel.textColor = UIColor(named: "Forest")?.withAlphaComponent(0.8)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(emojiLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),

            emojiLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -100),

            titleLabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])

        return containerView
    }

    private func setupActions() {
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func nextTapped() {
        if currentPage < pages.count - 1 {
            currentPage += 1
            let offsetX = CGFloat(currentPage) * scrollView.frame.width
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            updateUI()
        } else {
            completeOnboarding()
        }
    }

    @objc private func skipTapped() {
        completeOnboarding()
    }

    private func updateUI() {
        pageControl.currentPage = currentPage

        if currentPage == pages.count - 1 {
            nextButton.setTitle("Get Started", for: .normal)
            skipButton.isHidden = true
        } else {
            nextButton.setTitle("Next", for: .normal)
            skipButton.isHidden = false
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    private func completeOnboarding() {
        // Mark onboarding as complete
        SharedUserDefaults.shared.set(true, forKey: "hasCompletedOnboarding")

        // Haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        // Call completion handler
        onComplete?()
    }
}

// MARK: - ScrollView Delegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        currentPage = Int(pageIndex)
        updateUI()
    }
}
