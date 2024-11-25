<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Term Life Insurance Details</title>
    <link rel="stylesheet" href="resources/css/details.css">
</head>
<body>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1>Secure Your Family’s Future with Term Life Insurance</h1>
            <p>Affordable protection for your loved ones in uncertain times.</p>
            <div class="hero-cta">
                <button class="btn-primary">Get a Free Quote Now</button>
                <a href="#compare" class="compare-link">Compare Plans</a>
            </div>
        </div>
        <img src="resources/images/family-banner.jpg" alt="Happy Family" class="hero-image">
    </section>

    <!-- Introduction Section -->
    <section class="intro">
        <h2>What is Term Life Insurance?</h2>
        <p>
            Term Life Insurance offers coverage for a fixed period, ensuring financial security for your dependents in case of unexpected events. It is one of the most affordable and flexible insurance options.
        </p>
        <div class="benefits">
            <h3>Benefits of Term Life Insurance</h3>
            <ul>
                <li>Financial security for your family.</li>
                <li>High coverage with low premiums.</li>
                <li>Customizable terms (e.g., 10, 20, or 30 years).</li>
                <li>Tax benefits (as per local regulations).</li>
            </ul>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="why-choose">
        <h2>Why Choose Us?</h2>
        <ul>
            <li>Low premiums guaranteed.</li>
            <li>Customizable plans tailored to your needs.</li>
            <li>Trusted by thousands of families.</li>
            <li>Hassle-free claim settlement process.</li>
        </ul>
    </section>

    <!-- Key Features Section -->
    <section class="features">
        <h2>Key Features of Our Term Life Insurance</h2>
        <ul>
            <li><strong>Coverage Options:</strong> Plans starting at $50,000 to $1,000,000 or more.</li>
            <li><strong>Policy Duration:</strong> 10, 20, or 30 years.</li>
            <li><strong>Add-Ons:</strong> Riders such as critical illness, accidental death, and waiver of premium.</li>
            <li><strong>Premium Payment Modes:</strong> Monthly, quarterly, yearly.</li>
        </ul>
    </section>

    <!-- Premium Calculator Section -->
    <section class="premium-calculator">
        <h2>Premium Calculator</h2>
        <form action="CalculatePremiumServlet" method="post" class="calculator-form">
            <label for="age">Age:</label>
            <input type="number" id="age" name="age" required>

            <label for="income">Income:</label>
            <input type="number" id="income" name="income" required>

            <label for="coverage">Coverage Amount:</label>
            <input type="number" id="coverage" name="coverage" required>

            <label for="term">Term Length:</label>
            <select id="term" name="term" required>
                <option value="10">10 Years</option>
                <option value="20">20 Years</option>
                <option value="30">30 Years</option>
            </select>

            <button type="submit" class="btn-primary">Calculate Premium</button>
        </form>
    </section>

    <!-- Example Scenarios Section -->
    <section class="examples">
        <h2>Example Scenarios</h2>
        <div class="scenario">
            <h3>John, 35</h3>
            <p>Opted for a 20-year policy with $500,000 coverage for just $20/month.</p>
        </div>
        <div class="scenario">
            <h3>Mary, 40</h3>
            <p>Secured her family with a $1,000,000 policy for $35/month.</p>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq">
        <h2>Frequently Asked Questions</h2>
        <details>
            <summary>What is term life insurance?</summary>
            <p>A policy that provides financial security for a fixed term.</p>
        </details>
        <details>
            <summary>Who should buy term insurance?</summary>
            <p>Anyone looking to provide financial security for their family.</p>
        </details>
        <details>
            <summary>What happens if I outlive my policy?</summary>
            <p>The policy expires, and you can renew or convert it into a whole life policy.</p>
        </details>
        <details>
            <summary>Can I add riders to my policy?</summary>
            <p>Yes, you can add options like critical illness or accidental death coverage.</p>
        </details>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials">
        <h2>Testimonials</h2>
        <blockquote>
            "Thanks to XYZ Insurance, my family was financially secure during tough times."
        </blockquote>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <h2>Protect your loved ones with the best term life insurance plan.</h2>
        <!-- Updated "Buy Now" Button to link to purchasePlan.jsp -->
        <a href="purchasePlan.jsp" class="btn-primary">Buy Now</a>
        <button class="btn-secondary" onclick="window.location.href='contactAdvisor.jsp'">Talk to an Advisor</button>
    </section>

</body>
</html>
