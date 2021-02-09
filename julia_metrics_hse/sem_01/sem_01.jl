### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 793ef94e-6ad0-11eb-0041-41e48d94cca1
using DataFrames, GLM, Statistics, CSV, Econometrics

# ╔═╡ 7efeacc6-6ad0-11eb-0fd8-2db29f9da968
using RDatasets

# ╔═╡ 4452cbc8-6ad0-11eb-237a-5bc3d9a4a138
md"### Packages"

# ╔═╡ 6213445a-6ad0-11eb-164f-e53c54ef3275
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

# ╔═╡ 6955a2f8-6ad0-11eb-2b28-4b3c40043142
begin
    Pkg.add("DataFrames")
end

# ╔═╡ 70422492-6ad0-11eb-3c24-7f05958d9d7e
begin
    Pkg.add("CSV")
end

# ╔═╡ 83f86d0c-6ad0-11eb-2988-07a3de8b62c3
md"### First seminar"

# ╔═╡ 8fb3801e-6ad0-11eb-315a-19a3f050805f
psid = dataset("Ecdat", "PSID")

# ╔═╡ 9956a182-6ad0-11eb-3e62-c1a4c0c962dc
psid.Age

# ╔═╡ 98e42db4-6ad0-11eb-1237-1771e1402dce
describe(psid)

# ╔═╡ 98b81576-6ad0-11eb-2049-1db6e27a48fc
first(psid, 7)

# ╔═╡ a6c97ee8-6ad0-11eb-35c8-23dc8a664185
model_a = fit(EconometricModel, @formula(log(1+Earnings) ~ Age + Educatn), psid)

# ╔═╡ a684b6f0-6ad0-11eb-0d51-f3b74dd50ee6


# ╔═╡ Cell order:
# ╟─4452cbc8-6ad0-11eb-237a-5bc3d9a4a138
# ╠═6213445a-6ad0-11eb-164f-e53c54ef3275
# ╠═6955a2f8-6ad0-11eb-2b28-4b3c40043142
# ╠═70422492-6ad0-11eb-3c24-7f05958d9d7e
# ╠═793ef94e-6ad0-11eb-0041-41e48d94cca1
# ╠═7efeacc6-6ad0-11eb-0fd8-2db29f9da968
# ╟─83f86d0c-6ad0-11eb-2988-07a3de8b62c3
# ╠═8fb3801e-6ad0-11eb-315a-19a3f050805f
# ╠═9956a182-6ad0-11eb-3e62-c1a4c0c962dc
# ╠═98e42db4-6ad0-11eb-1237-1771e1402dce
# ╠═98b81576-6ad0-11eb-2049-1db6e27a48fc
# ╠═a6c97ee8-6ad0-11eb-35c8-23dc8a664185
# ╠═a684b6f0-6ad0-11eb-0d51-f3b74dd50ee6
