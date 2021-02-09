### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 15e90aac-570b-11eb-263f-af584fd85087
using RDatasets

# ╔═╡ bdc13c66-5717-11eb-0f23-6fe39d6d734f
using Plots

# ╔═╡ abc65af8-570f-11eb-2d72-194213de9f08
md"### Simple operations"

# ╔═╡ 1edca972-5704-11eb-1f25-1300850f7714
A=[12,3]

# ╔═╡ 29ccf490-5704-11eb-3ed4-1160d6a5513b
print(A)

# ╔═╡ 2e675428-5704-11eb-1a7b-b17f6f498fe2
y = [3 4 5]'

# ╔═╡ 560339a2-5704-11eb-1a9a-cdfec5eada20
X = [1 1 1; 1 6 7]'

# ╔═╡ 58595010-5704-11eb-170d-afb5b5f1cc93
(X'X)^(-1)*X'y

# ╔═╡ 612195e0-5704-11eb-24c9-399a29bbbb13
f(x) = 2x^3 + 3x^2 + 6

# ╔═╡ 6986da06-5704-11eb-2c8b-13073a875817
f(2)

# ╔═╡ 8074e2ce-5706-11eb-03b0-919392d8fcc3
md"### Packages"

# ╔═╡ 68c3b13c-570b-11eb-2bf3-733cffacae66
begin
	import Pkg
	Pkg.add("RDatasets")
	Pkg.add("Econometrics")
	Pkg.add("GLM")
	Pkg.add("CSV")
	Pkg.add("Gadfly")
	Pkg.add("LinearAlgebra")
	Pkg.add("Plots")
	Pkg.add("PyPlot")
end

# ╔═╡ 1a7b5882-5717-11eb-26e1-11e730af5a93
let
	Pkg.activate("Plots")
	Pkg.add("Plots")
	using Plots
end

# ╔═╡ c4a61c90-5717-11eb-32db-ad03f3dd3776
let
	Pkg.activate("Plots")
	Pkg.add("Plots")
	using Plots
end

# ╔═╡ 08c862a6-5708-11eb-2029-237f882aca18
begin
    Pkg.add("DataFrames")
end

# ╔═╡ 5ac9c538-5717-11eb-16f1-4320e5e4468a
begin
    Pkg.add("CSV")
end

# ╔═╡ 183bb3d2-5708-11eb-0252-bde426d7f37d
md"### First seminar"

# ╔═╡ d6817fba-5706-11eb-171d-91ca739f379f
psid = dataset("Ecdat", "PSID")

# ╔═╡ 4ab7e4b4-5707-11eb-09af-d1a4aba2b61d
psid.Age

# ╔═╡ 52ed47fa-5707-11eb-2e12-257b5efb676b
describe(psid)

# ╔═╡ 5a8b3e18-5707-11eb-316a-31f34638fa39
first(psid, 7)

# ╔═╡ 632b2cb0-570f-11eb-2f7e-7966a41c4619
md"#### Model first seminar"

# ╔═╡ 65684344-5707-11eb-051d-8b7c3ee6d1db
model_a = fit(EconometricModel, @formula(log(1+Earnings) ~ Age + Educatn), psid)

# ╔═╡ 268705c6-5708-11eb-392b-198e37362b47
md"### Second seminar"

# ╔═╡ fe7d65b4-5707-11eb-0381-ff0c21399f69
diamonds = dataset("ggplot2", "diamonds")

# ╔═╡ 4acad240-570c-11eb-24dd-afb2d45d1811
CSV.write("diam.csv", diamonds)

# ╔═╡ 6e1ab4b8-570c-11eb-2c52-930d0cd28c03
diamonds[!, [:Cut,:Table]]

# ╔═╡ 8a1003e4-570c-11eb-28ec-fda1b255596d
diamonds[2:5, [:Cut,:Table]]

# ╔═╡ ee0b4c82-5707-11eb-1f7a-a398be7e24c0
diamonds.Cut

# ╔═╡ ecdb599c-5707-11eb-3cbc-ff625c6e304d
diamonds[!, :Cut]

# ╔═╡ 6b7ebf2e-5707-11eb-12a4-c9223a97a2e4
describe(diamonds)

# ╔═╡ 50e27124-5707-11eb-3aa2-c1670efa0879
diamonds[diamonds.X .>6, ["Cut"]] #отбор строк

# ╔═╡ 316dfbb6-5710-11eb-2f2f-b3ad04075a89
md"#### Model"

# ╔═╡ 5c6a75e2-570d-11eb-2bf1-512001f49184
model = fit(EconometricModel, @formula(Price~1+Carat+X+Y+Z), diamonds)

# ╔═╡ 5c478968-570d-11eb-1a2f-3725ac74710b
vcov(model)

# ╔═╡ dc4b51b2-570d-11eb-1400-19c57f1c1b6e
vcov(model, HC1)

# ╔═╡ dbf16fce-570d-11eb-2a21-a987f21a950e
vcov(model, HC0) #Уайта

# ╔═╡ 0a954b36-570e-11eb-0e3a-bb4f84b5b70d
coef(model)

# ╔═╡ 0a7d71fa-570e-11eb-3df1-9fd68edc3785
residuals(model)

# ╔═╡ 0a5e15b4-570e-11eb-02b5-09e8a33a7922
fitted(model)

# ╔═╡ 1fd631f4-570e-11eb-2596-d53962e14878
coeftable(model)

# ╔═╡ 1fbd6822-570e-11eb-239a-7bf720458479
confint(model, level=0.9, se=sqrt.(diag(vcov(model, HC1))))

# ╔═╡ 983c6fae-5714-11eb-1250-9997e91e85e1
md"### Tests"

# ╔═╡ 6a4f936a-5711-11eb-0316-1db7c98e536a
aic(model)

# ╔═╡ 6a1e4564-5711-11eb-3bd3-137c634c85b9
bic(model)

# ╔═╡ bc873486-5712-11eb-287f-a3ce446cdb07
diamonds[!, "plot2"] = diamonds[!, :Price] .^2

# ╔═╡ 9e006072-570e-11eb-227a-c77fd1e6e613
diamonds[!, "resid2"] = residuals(model) .^2

# ╔═╡ 8b471d60-5711-11eb-103f-ef696172d4ed
aux_model = fit(EconometricModel, @formula(resid2~Carat+X+Carat^2+X^2+X*Carat),diamonds)

# ╔═╡ 292fd288-5712-11eb-18dd-15528073da24
md"### Graphics"

# ╔═╡ 9dbd6cae-570e-11eb-1791-35685d8d9359
iris = dataset("datasets", "iris")

# ╔═╡ 402780e8-5727-11eb-3e85-2552aabfff0d
plotly()

# ╔═╡ d88c5052-570e-11eb-170d-fb3384b327b6
histogram(iris.SepalLength)

# ╔═╡ 59047678-5710-11eb-1e32-77628f2ddc8e
scatter(iris.SepalLength, iris.PetalLength)

# ╔═╡ 6709f8f0-5711-11eb-244b-9d98824dc761


# ╔═╡ 3c005270-5717-11eb-0653-dde909db438e
using CSV

# ╔═╡ 5229cc40-5709-11eb-2f6f-5d2824769002
using DataFrames, GLM, Statistics, CSV, Econometrics

# ╔═╡ Cell order:
# ╟─abc65af8-570f-11eb-2d72-194213de9f08
# ╠═1edca972-5704-11eb-1f25-1300850f7714
# ╠═29ccf490-5704-11eb-3ed4-1160d6a5513b
# ╠═2e675428-5704-11eb-1a7b-b17f6f498fe2
# ╠═560339a2-5704-11eb-1a9a-cdfec5eada20
# ╠═58595010-5704-11eb-170d-afb5b5f1cc93
# ╠═612195e0-5704-11eb-24c9-399a29bbbb13
# ╠═6986da06-5704-11eb-2c8b-13073a875817
# ╟─8074e2ce-5706-11eb-03b0-919392d8fcc3
# ╠═68c3b13c-570b-11eb-2bf3-733cffacae66
# ╠═08c862a6-5708-11eb-2029-237f882aca18
# ╠═5ac9c538-5717-11eb-16f1-4320e5e4468a
# ╠═3c005270-5717-11eb-0653-dde909db438e
# ╠═5229cc40-5709-11eb-2f6f-5d2824769002
# ╠═15e90aac-570b-11eb-263f-af584fd85087
# ╠═1a7b5882-5717-11eb-26e1-11e730af5a93
# ╟─183bb3d2-5708-11eb-0252-bde426d7f37d
# ╠═d6817fba-5706-11eb-171d-91ca739f379f
# ╠═4ab7e4b4-5707-11eb-09af-d1a4aba2b61d
# ╠═52ed47fa-5707-11eb-2e12-257b5efb676b
# ╠═5a8b3e18-5707-11eb-316a-31f34638fa39
# ╟─632b2cb0-570f-11eb-2f7e-7966a41c4619
# ╠═65684344-5707-11eb-051d-8b7c3ee6d1db
# ╟─268705c6-5708-11eb-392b-198e37362b47
# ╠═fe7d65b4-5707-11eb-0381-ff0c21399f69
# ╠═4acad240-570c-11eb-24dd-afb2d45d1811
# ╠═6e1ab4b8-570c-11eb-2c52-930d0cd28c03
# ╠═8a1003e4-570c-11eb-28ec-fda1b255596d
# ╠═ee0b4c82-5707-11eb-1f7a-a398be7e24c0
# ╠═ecdb599c-5707-11eb-3cbc-ff625c6e304d
# ╠═6b7ebf2e-5707-11eb-12a4-c9223a97a2e4
# ╠═50e27124-5707-11eb-3aa2-c1670efa0879
# ╟─316dfbb6-5710-11eb-2f2f-b3ad04075a89
# ╠═5c6a75e2-570d-11eb-2bf1-512001f49184
# ╠═5c478968-570d-11eb-1a2f-3725ac74710b
# ╠═dc4b51b2-570d-11eb-1400-19c57f1c1b6e
# ╠═dbf16fce-570d-11eb-2a21-a987f21a950e
# ╠═0a954b36-570e-11eb-0e3a-bb4f84b5b70d
# ╠═0a7d71fa-570e-11eb-3df1-9fd68edc3785
# ╠═0a5e15b4-570e-11eb-02b5-09e8a33a7922
# ╠═1fd631f4-570e-11eb-2596-d53962e14878
# ╠═1fbd6822-570e-11eb-239a-7bf720458479
# ╟─983c6fae-5714-11eb-1250-9997e91e85e1
# ╠═6a4f936a-5711-11eb-0316-1db7c98e536a
# ╠═6a1e4564-5711-11eb-3bd3-137c634c85b9
# ╠═bc873486-5712-11eb-287f-a3ce446cdb07
# ╠═9e006072-570e-11eb-227a-c77fd1e6e613
# ╠═8b471d60-5711-11eb-103f-ef696172d4ed
# ╟─292fd288-5712-11eb-18dd-15528073da24
# ╠═9dbd6cae-570e-11eb-1791-35685d8d9359
# ╠═c4a61c90-5717-11eb-32db-ad03f3dd3776
# ╠═bdc13c66-5717-11eb-0f23-6fe39d6d734f
# ╠═402780e8-5727-11eb-3e85-2552aabfff0d
# ╠═d88c5052-570e-11eb-170d-fb3384b327b6
# ╠═59047678-5710-11eb-1e32-77628f2ddc8e
# ╠═6709f8f0-5711-11eb-244b-9d98824dc761
