<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Criteria;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ProductRepository")
 */
class Product
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=20, unique=true)
     */
    private $sku;

    /**
     * @ORM\Column(type="string", nullable=true)
     */
    private $title;

    /**
     * @ORM\Column(type="decimal", scale=2, nullable=true)
     */
    private $price;

    /**
     * @ORM\ManyToMany(targetEntity="Category", inversedBy="products")
     */
    private $categories;

    /**
     * @ORM\OneToMany(targetEntity="ProductFeature", mappedBy="product")
     */
    private $features;

    /**
     * @ORM\ManyToOne(targetEntity="Product", inversedBy="productModifications")
     * @ORM\JoinColumn(name="product_base_id", referencedColumnName="id")
     */
    private $productBase;

    /**
     * @ORM\OneToMany(targetEntity="Product", mappedBy="productBase")
     */
    private $productModifications;

    /**
     * Product constructor.
     */
    public function __construct()
    {
        $this->categories = new ArrayCollection();
        $this->productModifications = new ArrayCollection();
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getSku()
    {
        return $this->sku;
    }

    /**
     * @param mixed $sku
     */
    public function setSku($sku): void
    {
        $this->sku = $sku;
    }

    /**
     * @return mixed
     */
    public function getTitle()
    {
        return (!$this->title && $this->getProductBase()) ? $this->getProductBase()->getTitle() : $this->title;
    }

    /**
     * @param mixed $title
     */
    public function setTitle($title): void
    {
        $this->title = $title;
    }

    /**
     * @return mixed
     */
    public function getPrice()
    {
        return (!$this->price && $this->getProductBase()) ? $this->getProductBase()->getPrice() : $this->price;
    }

    /**
     * @param mixed $price
     */
    public function setPrice($price): void
    {
        $this->price = $price;
    }

    /**
     * @return mixed
     */
    public function getCategories()
    {
        return $this->categories;
    }

    /**
     * @param mixed $categories
     */
    public function setCategories($categories): void
    {
        $this->categories = $categories;
    }

    /**
     * @return mixed
     */
    public function getFeatures()
    {
        return $this->features;
    }

    /**
     * @return mixed
     */
    public function getFeaturesByLang($lang)
    {
        $criteria = Criteria::create()
            ->where(Criteria::expr()->eq("lang", $lang));
        return $this->features->matching($criteria);
    }

    /**
     * @param mixed $features
     */
    public function setFeatures($features): void
    {
        $this->features = $features;
    }

    /**
     * @return mixed
     */
    public function getProductBase()
    {
        return $this->productBase;
    }

    /**
     * @return mixed
     */
    public function getProductBaseView()
    {
        return ($this->getProductBase()) ? $this->getProductBase() : $this;
    }

    /**
     * @param mixed $productBase
     */
    public function setProductBase($productBase): void
    {
        $this->productBase = $productBase;
    }

    /**
     * @return mixed
     */
    public function getProductModifications()
    {
        return $this->productModifications;
    }

    /**
     * @param mixed $productModifications
     */
    public function setProductModifications($productModifications): void
    {
        $this->productModifications = $productModifications;
    }

}
